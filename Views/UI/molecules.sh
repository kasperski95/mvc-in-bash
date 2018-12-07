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

car_simpleListElement() {
    echo "$Car_ID - $Car_brand"
}

transaction_listElement() {
    echo "$Transaction_ID - $Transaction_title"
}