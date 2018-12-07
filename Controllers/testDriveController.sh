#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${USER}


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
    ui_list Car ui_car "${Cars[@]}"
  
    testDrive_handle $?
    
    return $?
}


testDrive_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    ui_header "JAZDA TESTOWA: ${Car_brand}"
    
    local testDriveDate
    while [[ ! $testDriveDate =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; do
        ui_header "JAZDA TESTOWA: ${Car_brand}"
        if [ "$testDriveDate" != "" ]; then
            echo "Niepoprawna data."
        fi
        read -p "Data [YYYY-MM-DD]: " testDriveDate
    done;
    echo ""

    ui_actions "Potwierdź"

    if [ $? == "1" ]; then
        TestDrive_UserID=$USER
        TestDrive_CarID=$1
        TestDrive_date=$testDriveDate    
        db_save TestDrive
        return 0
    fi
    return 3;
}