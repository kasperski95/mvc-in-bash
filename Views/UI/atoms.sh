#!/bin/bash

source ./config.sh

ui_line() {
    local i=0
    echo ""
    while [ $i -lt $WIDTH ]; do
        printf "—"
        ((i++))
    done
    echo "" 
    return 0
}