#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${USER_ID}


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
    ui_list Car ui_car "${Cars[@]}"
    
    reserve_handle $?
    
    return $?
}


reserve_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1

    Transaction_UserID=$USER_ID
    Transaction_CarID=$Car_ID
    Transaction_title="Rezerwacja samochodu - ${Car_brand}"
    Transaction_sum=$(echo "scale=0;$Car_price/10" | bc)
    Transaction_currency=$Car_currency
    Transaction_date=$(date)
    db_save Transaction

    
    Car_reservedByUserID=$USER_ID
    db_save Car $1

    ui_header "${Car_brand}"
    
    return 0
}