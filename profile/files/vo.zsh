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

function repl() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tab-reset" INT EXIT
        if [[ "$*" =~ "prod" ]]; then
            echo "Connecting to Production REPL"
            tabc Red
        elif [[ "$*" =~ "stage" ]]; then
            echo "Connecting to Staging REPL"
            tabc Purple
        else
            tabc Blue
        fi
    fi
    eval "~/victorops/platform/scripts/repl $*"
}
compdef _ssh tabc=ssh
