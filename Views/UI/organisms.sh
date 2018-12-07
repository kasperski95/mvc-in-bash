#!/bin/bash

source ./config.sh
source ./Views/UI/atoms.sh
source ./Views/UI/molecules.sh
source ./Services/db.sh


ui_list() {
    local modelName=$1 && shift 1
    local format=$1 && shift 1
    local IDs=("$@")
    for id in ${IDs[@]}; do
        db_import $modelName $id
        $format
    done
    
    ui_footer
    return $?
}


ui_actions() {
    local arr=("$@")
    for i in ${!arr[@]}; do
        echo "$(($i+1)) - ${arr[$i]}"
    done
    
    ui_footer
    return $?
}