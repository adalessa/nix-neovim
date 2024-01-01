# My Neovim configuration in Nix
Version en español [aqui](./README_es.md)

This configuration it's a bit different from the usual neovim config. Which is mostly different is that is highly integrated with Nix.
To start with, Nix is not a replacement of Lua or vimscript, under the hood nix is just generating the lua files which neovim executable will
use and load.

[NixVim](https://github.com/nix-community/nixvim) is the core which I am using since they took the main work to create
this tranlation layer with nix to be able to configure with nix really easily.

The main advantage of this approach is that with this build I can integrate programs from lsp to programming languages and more.
Before this I would do this with lazy for the packages and mason for the tools, the problem is that we are limitted
to the version on the package manager and tools like mason still depends on different instalation tools depending
the tool to install.
With nix I have all that resolve and does not matter since Nix will work in any linux distro or mac.

This approach also allows me to have different *builds* to my needs for example my main config is not the same as the one that I use for work
So I built [Main](./config/main.nix) and [Work](./config/work.nix).

I can easily use the in any machine that have nix package manager installed using flakes

`nix run github:/adalessa/nix-neovim` with this will use by default `main`.

in order to use flakes you may need to use `--experimental-features 'nix-command flakes'` flag.
