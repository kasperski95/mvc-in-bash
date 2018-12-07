#!/bin/bash

source ./config.sh
source ./Views/UI/atoms.sh
source ./Views/UI/molecules.sh
source ./Services/db.sh


ui_list() {
    while [ "$#" -gt "0" ]; do
        echo "$1" && shift 1
    done
    echo ""
}


ui_actions() {
    arr=("$@")
    for i in ${!arr[@]}; do
        echo "$(($i+1)) - ${arr[$i]}"
    done
    
    ui_footer
    return $?
}