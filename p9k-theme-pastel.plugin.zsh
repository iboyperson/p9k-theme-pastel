# Set different config if in tty
if [[ -n $DISPLAY ]]; then
    typeset -gAh __PASTEL_COLORS=(
        red 009
        green 010
        brightgreen 041
        yellow 011
        blue 012
        purple 134
    )
    PROMPT_PREFIX_CHAR="❯"
else
    typeset -gAh __PASTEL_COLORS=(
        red 001
        green 002
        brightgreen 002
        yellow 003
        blue 004
        purple 005
    )
    PROMPT_PREFIX_CHAR=">"
    POWERLEVEL9K_IGNORE_TERM_COLORS=true
fi

_pastel_config_user() {
    POWERLEVEL9K_USER_DEFAULT_BACKGROUND='none'
    POWERLEVEL9K_USER_SUDO_BACKGROUND='none'
    POWERLEVEL9K_USER_ROOT_BACKGROUND='none'
}

_pastel_config_dir() {
    POWERLEVEL9K_SHORTEN_DELIMITER='...'
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=7

    POWERLEVEL9K_ETC_ICON=''
    POWERLEVEL9K_FOLDER_ICON=''
    POWERLEVEL9K_HOME_ICON=''
    POWERLEVEL9K_HOME_SUB_ICON=''

    POWERLEVEL9K_DIR_ETC_BACKGROUND='none'
    POWERLEVEL9K_DIR_ETC_FOREGROUND="$__PASTEL_COLORS[purple]"
    POWERLEVEL9K_DIR_HOME_BACKGROUND='none'
    POWERLEVEL9K_DIR_HOME_FOREGROUND="$__PASTEL_COLORS[blue]"
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='none'
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="$__PASTEL_COLORS[purple]"
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='none'
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="$__PASTEL_COLORS[blue]"
}

_pastel_config_vcs() {
    POWERLEVEL9K_VCS_GIT_ICON=''
    POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
    POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=''
    POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
    POWERLEVEL9K_VCS_BRANCH_ICON=''
    POWERLEVEL9K_VCS_COMMIT_ICON=''
    POWERLEVEL9K_VCS_UNTRACKED_ICON="%F{$__PASTEL_COLORS[red]}%B?%b%f"
    POWERLEVEL9K_VCS_UNSTAGED_ICON="%F{$__PASTEL_COLORS[yellow]}%B!%b%f"
    POWERLEVEL9K_VCS_STAGED_ICON="%F{$__PASTEL_COLORS[green]}%B+%b%f"
    POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="%F{$__PASTEL_COLORS[yellow]}%B>%b%f"
    POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="%F{$__PASTEL_COLORS[yellow]}%B<%b%f"
    POWERLEVEL9K_VCS_STASH_ICON="%F{$__PASTEL_COLORS[yellow]}%B*%b%f"

    POWERLEVEL9K_SHOW_CHANGESET=false
    POWERLEVEL9K_CHANGESET_HASH_LENGTH=6

    POWERLEVEL9K_VCS_CLEAN_BACKGROUND='none'
    POWERLEVEL9K_VCS_CLEAN_FOREGROUND="$__PASTEL_COLORS[brightgreen]"
    POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='none'
    POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="$__PASTEL_COLORS[purple]"
    POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='none'
    POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="$__PASTEL_COLORS[yellow]"
}

_pastel_config_virtualenv() {
    POWERLEVEL9K_PYTHON_ICON=''
    POWERLEVEL9K_VIRTUALENV_BACKGROUND='none'
    POWERLEVEL9K_VIRTUALENV_FOREGROUND="$__PASTEL_COLORS[green]"
}

_pastel_config_status() {
    POWERLEVEL9K_CARRIAGE_RETURN_ICON=''
    POWERLEVEL9K_STATUS_OK=false
    POWERLEVEL9K_STATUS_OK_BACKGROUND='none'
    POWERLEVEL9K_STATUS_ERROR_BACKGROUND='none'
    POWERLEVEL9K_STATUS_OK_FOREGROUND="$__PASTEL_COLORS[green]"
    POWERLEVEL9K_STATUS_ERROR_FOREGROUND="$__PASTEL_COLORS[red]"
} 

_pastel_config_p9k() {
    [ -v POWERLEVEL9K_LEFT_PROMPT_ELEMENTS ] || POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs virtualenv)
    [ -v POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS ] || POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

    POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
    POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
    POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=''
    POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
    POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
    POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS=''

    for x in $POWERLEVEL9K_LEFT_PROMPT_ELEMENTS $POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS; do 
        if typeset -f _pastel_config_$x > /dev/null; then
            _pastel_config_$x
        fi
    done

    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
    POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=''
    POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%(?.%F{$__PASTEL_COLORS[blue]}$PROMPT_PREFIX_CHAR%f.%F{$__PASTEL_COLORS[red]}$PROMPT_PREFIX_CHAR%f) "
    PS2="$POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX"
    PS3="$POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX"
}

_pastel_init() {
    _pastel_config_p9k
    if typeset -f _pastel_custom_config > /dev/null; then
        _pastel_custom_config
    fi
}