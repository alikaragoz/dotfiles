#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Load any alias files.
if [ -d $HOME/.dotfiles/zsh/aliases/ ]; then
  if [ "$(ls -A $HOME/.dotfiles/zsh/aliases/)" ]; then
    for config_file ($HOME/.dotfiles/zsh/aliases/*.zsh) source $config_file
  fi
fi
