# Mi configuration de neovim Neovim en Nix
English versions [here](./README.md)

Esta configuración es un poco diferente de la configuración habitual de Neovim. Lo que la hace principalmente diferente es que está altamente integrada con Nix.
Para empezar, Nix no es un reemplazo de Lua o vimscript; en realidad, bajo el capó, Nix simplemente genera los archivos Lua que el ejecutable de Neovim utilizará y cargará.

[NixVim](https://github.com/nix-community/nixvim) es el núcleo que estoy utilizando, ya que realizaron el trabajo principal para crear esta capa de traducción con Nix para poder configurar con Nix de manera realmente fácil.

La principal ventaja de este enfoque es que con esta construcción puedo integrar programas desde el Language Server Protocol (LSP) hasta lenguajes de programación y más. Antes, lo hacía con lazy para los paquetes y mason para las herramientas, pero el problema es que estábamos limitados a la versión en el gestor de paquetes y herramientas como mason aún dependen de diferentes herramientas de instalación según la herramienta a instalar.
Con Nix, tengo todas esas resueltas y no importa, ya que Nix funcionará en cualquier distribución de Linux o en Mac.

Este enfoque también me permite tener diferentes *conjuntos de construcción* según mis necesidades. Por ejemplo, mi configuración principal no es la misma que la que uso para trabajar, así que construí [Main](./config/main.nix) y [Work](./config/work.nix).

Puedo usarlos fácilmente en cualquier máquina que tenga instalado el gestor de paquetes Nix utilizando flakes:

`nix run github:/adalessa/nix-neovim` y con esto se utilizará `main` de forma predeterminada.

Para usar flakes, es posible que necesites utilizar la bandera `--experimental-features 'nix-command flakes'`.
