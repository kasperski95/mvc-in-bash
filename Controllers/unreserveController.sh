#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${USER}


unreserve_index() {
    title="ODREZERWUJ"
    ui_header "${title}"
    
    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $USER == $Car_reservedByUserID ]; then
            Cars+=("$Car_ID")
        fi
    done
    ui_list Car ui_car "${Cars[@]}"
    
    unreserve_handle $?
    
    return $?
}


unreserve_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    Car_reservedByUserID=$DEALER;
    db_save Car $1
    
    title="ODREZERWOWANIE: ${Car_brand}"
    return 0
}