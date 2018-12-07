#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${User_ID}


testDrive_index() {
    title="JAZDA TESTOWA"
    ui_header "${title}"
    
    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $Car_UserID == $DEALER ] && [ $Car_reservedByUserID == $DEALER ]; then
            Cars+=("$Car_ID")
        fi
    done
    ui_list Car car_simpleListElement "${Cars[@]}"
    
    testDrive_handle $?
    
    return $?
}


testDrive_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    ui_header "JAZDA TESTOWA: ${Car_brand}"
    
    local date
    while [[ ! $date =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; do
        ui_header "JAZDA TESTOWA: ${Car_brand}"
        if [ "$date" != "" ]; then
            echo "Niepoprawna data."
        fi
        read -p "Data [YYYY-MM-DD]: " date
    done;
    echo ""
    ui_line

    TestDrive_UserID=$User_ID
    TestDrive_Date=$date    
    db_save TestDrive
    
    return 0
}