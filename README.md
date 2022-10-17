# Crystalis Disassembly

This is a repository to track the disassembly of the Crystalis game.
Because the game is proprietary, we do not store the actual bytes or
opcodes in this repository.  Instead, we clean the disassembly to only
include hand-written comments or formatting, and whether any given
locus is code or data.

## Usage

To use this repository, you must have a legally-obtained dump of the
Crystalis data, stored in a file `Crystalis.nes` at the top level
of the repository.  You must also copy/link `scripts/git-disasm`
to somewhere in your `$PATH` so that running `git-disasm` from a bare
command-line produces an error "No action given" rather than something
like "command not found".

Then run the following:

```sh
git config --local include.path ../.gitconfig
rm Crystalis.s
git checkout Crystalis.s
```

This should rehydrate the file in your local repository to include
all the proprietary data from the dump.

From this point on, you may edit `Crystalis.s` as you see fit.
