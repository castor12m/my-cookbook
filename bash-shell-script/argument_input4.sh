#!/bin/bash
# scmd (Simple Command)

## Print usage
usage() {
    echo 'Simple Command'
    echo '  -l, --length  LENGTH   Parameter Test'
    echo '  -s                     Option Test'
    echo '  -v, --verbose          Increase verbosity'
    exit 1
}

log() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}

## Print Args
TOTAL_ARGS=$#
ALL_ARGS=("$@")

log "Number of args: [${TOTAL_ARGS}]"
log "All args: [${ALL_ARGS[*]}]"

## Parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        --hello)
            shift
            ;;
        --test)
            TEST=true
            shift
            ;;
        --length|-l)
            LENGTH="$2"
            if [[ -z "$LENGTH" || "$LENGTH" == --* ]]; then
                log "> Error: --length requires a value"
                usage
            fi
            shift 2
            ;;

        --help|-h)
            usage
            shift
            ;;
        --verbose|-v)
            VERBOSE='true'
            log 'Verbose mode: [on]'
            shift
            ;;

        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

log '> Start script...'