#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${User_ID}


sell_index() {
    title="SPRZEDAJ"
    ui_header "${title}"
    
    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $Car_UserID == $User_ID ]; then
            Cars+=("$Car_brand")
        fi
    done
    ui_actions "${Cars[@]}"
    
    buy_handle $?
    
    return $?
}


sell_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    Car_UserID=1
    db_save Car $1

    ui_header "SPRZEDAJ: ${Car_brand}"
    
    return 1
}