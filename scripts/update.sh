#!/bin/sh

# Usage

# Usage: scripts/update.sh [--rom=/path/to/rom] [out|in|check]
#   out:
#     Expects Crystalis.s to be non-writable.
#     Reassembles it from the rom.
#     Saves a pristine copy in Crystalis.s.pristine for merging.
#   in:
#     Expects Crystalis.s to be writable.
#     Rebuilds the Crystalis.st template file.
#     Does a validity check to ensure it's correct.
#   check:
#     Fails if there's un-checked in changes
#   merge:
#     Merges changes to Crystalis.s into any upstream changes to Crystalis.st.
#     Leaves conflict markers as needed.
# If the rom is not specified, looks at all *.nes files in the current
# directory to find something with the correct crc32.

top=$(git rev-parse --show-toplevel)



source="$top/Crystalis.s"
pristine="$source.pristine"
template="$top/Crystalis.st"
strip="$top/scripts/strip"
rom=
action=
verbose=false

while [ $# -gt 0 ]; do
  case "$1" in
    (--rom)   shift; rom=$1   ;;
    (--rom=*) rom=${1#--rom=} ;;
    (-v)      verbose=true    ;;
    (out)     action=out      ;;
    (in)      action=in       ;;
    (merge)   action=merge    ;;
    (check)   action=check    ;;
    (*) echo "Bad option: $1" >& 2; exit 1 ;;
  esac
  shift
done

# Pick a default rom if present
if [ -z "$rom" ]; then
  rom=$(sha256sum *.nes | grep ^070d22fe | head -1)
  rom=$(echo ${rom#*48e1a967})
fi

if [ ! -f "$rom" ]; then
  echo "Could not find valid rom image with rom $rom" >& 2
  exit 2
fi

# Now do the action
case "$action" in
  (out)
    "$strip" -r "$rom"
    ;;
  (in)
    tmp=$(mktemp "$source.check.XXXX")
    cat > "$tmp.s"
    if ! "$strip" >| "$tmp.st"; then
      echo "Strip failed." >& 2
      exit 5
    fi
    if ! "$strip" -r "$rom" "$tmp.tpl" >| "$tmp"; then
      echo "Infuse failed."
      # TODO - allow keeping via an env var? (mention this in err)
      rm -f "$tmp" "$tmp.s" "$tmp.st"
      exit 6
    fi
    if ! diff --ignore-space-change -u "$tmp.s" "$tmp"; then
      echo "Differences found.  Leaving $(basename "$tmp.st") for comparison" >& 2
      exit 7
    fi
    cat "$tmp.st"
    rm -f "$tmp" "$tmp.s" "$tmp.st"
    ;;
  (*)
    echo "No action given" >& 2
    exit 1
    ;;
esac
