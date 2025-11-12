# config.nu
#
# Installed by: vt
# version = "0.108.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

# make sure homebrew is on the path
$env.PATH = ($env.PATH | append /opt/homebrew/bin)

$env.EDITOR = "nvim"
$env.config.show_banner = false
$env.config.cursor_shape.vi_insert = "line"
$env.config.cursor_shape.vi_normal = "block"
$env.config.edit_mode = 'vi'

source ~/.zoxide.nu
