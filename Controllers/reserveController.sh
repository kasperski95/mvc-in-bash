#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${USER}


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

    ui_header "PŁATNOŚĆ ZA: ${Car_brand} $Car_name" 
    ui_actions "Karta" "Gotówka" "Inna waluta"
    case "$?" in
        "1") Transaction_type="Płatność kartą";;
        "2") Transaction_type="Płatność gotówką";;
        "3") Transaction_type="Płatność inną walutą";;
        *) return 3
    esac
    Transaction_UserID=$USER
    Transaction_CarID=$Car_ID
    Transaction_title="Rezerwacja samochodu - ${Car_brand} $Car_name"
    Transaction_sum=$(echo "scale=0;$Car_price/10" | bc)
    Transaction_currency=$Car_currency
    Transaction_date=$(date)
    db_save Transaction

    Car_reservedByUserID=$USER
    db_save Car $1

    title="REZULTAT TRANSAKCJI"
    return 0
}