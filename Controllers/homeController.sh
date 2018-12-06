#!/bin/bash

source ./Services/db.sh
source ./Views/home.sh

db_import User 1


home_index() {
    local title="HOME"
    local skip=false;
    home_view "$title"
    case "$?" in
        *) skip=true ;;
    esac

    if ! $skip; then
        read -n 1 -s -r -p "wciśnij dowolny klawisz aby wrócić do menu..."
    fi
}