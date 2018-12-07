#!/bin/bash

source ./Views/UI/atoms.sh

ui_header() {
    clear
    printf "%s" "$1"
    ui_line
    echo ""
}

ui_footer() {
    echo "0 - Powrót"
    ui_line
    local action
    read -p ":" action
    if [ "$action" == "" ]; then
        action=0
    fi
    return $action
}

#---------------------------------------------

ui_car() {
    echo "$Car_ID - $Car_brand"
}

ui_transaction() {
    echo "$Transaction_ID - $Transaction_title"
}