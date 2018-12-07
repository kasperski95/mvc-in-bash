#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${User_ID}


reserve_index() {
    title="REZERWACJA"
    ui_header "${title}"
    
    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $Car_UserID == $DEALER ] && [ $Car_reservedByUserID == $DEALER ]; then
            Cars+=("$Car_ID")
        fi
    done
    ui_list Car car_simpleListElement "${Cars[@]}"
    
    reserve_handle $?
    
    return $?
}


reserve_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    Transaction_UserID=$User_ID
    Transaction_CarID=$Car_ID
    Transaction_title="Rezerwacja samochodu - ${Car_brand}"
    Transaction_sum=$(echo "scale=0;$Car_price/10" | bc)
    Transaction_currency=$Car_currency
    Transaction_date=$(date)
    db_save Transaction

    db_import Car $1
    Car_reservedByUserID=$User_ID
    db_save Car $1

    ui_header "${Car_brand}"
    
    return 0
}