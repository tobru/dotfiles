# Personal dotfiles - used by tobru

## Installation Notes

```sh
git clone https://github.com/tobru/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule update --init
scripts/bootstrap
scripts/install
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.
The install script takes the necessary steps to configure the tools (f.e. run `vundle`
in vim to install the plugins)

## Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Private Dotfiles

Some configuration parameters should not be publicly available. If you'd like to have
a repository for private config files, just create a directory `~/.private_dotfiles` with
the same directory structure like this one. The `bootstrap` script knows how to handle it
and the `ZSH` and `VIM` configuration is also able to handle it.

## Credits

This dotfiles repository including the scripts are based on the work of @holman [Zach Holman](https://github.com/holman)
Thanks @holman for the inspiration for creating this repository of dotfiles.
Many configuration ideas are based on the work of others found throughout the internet. Thanks to all of them.
