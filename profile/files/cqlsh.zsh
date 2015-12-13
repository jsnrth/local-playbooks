function tabc() {
  NAME=$1; if [ -z "$NAME" ]; then NAME="Default"; fi
  # if you have trouble with this, change
  # "Default" to the name of your default theme
  echo -e "\033]50;SetProfile=$NAME\a"
}

function tab-reset() {
    NAME="Default"
    echo -e "\033]50;SetProfile=$NAME\a"
    trap - INT EXIT
}

function colorcqlsh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "pr.*" ]]; then
            tabc Red
        elif [[ "$*" =~ "stg.*" ]]; then
            tabc Purple
        else
            tabc Blue
        fi
    fi
    cqlsh $*
}
compdef _cqlsh tabc=cqlsh

alias cqlsh="colorcqlsh"
