export BASH_SILENCE_DEPRECATION_WARNING=1

export LC_ALL=en_US.UTF-8

export LANG=en_US.UTF-8

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
