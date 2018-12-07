#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${USER}


buy_index() {
    title="ZAKUP POJAZDU"
    ui_header "${title}"
    
    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $Car_UserID == $DEALER ] && [ $Car_reservedByUserID == $DEALER ]; then
            Cars+=("$Car_ID")
        fi
    done
    ui_list Car ui_car "${Cars[@]}"
    
    buy_handle $?
    
    return $?
}


buy_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    Car_UserID=$USER
    Car_reservedByUserID=$USER
    

    ui_header "SPOSÓB ZAPŁATY ZA: ${Car_brand} $Car_name" 
    ui_actions "Karta" "Gotówka" "Inna waluta"
    case "$?" in
        "1") Transaction_type="Płatność kartą";;
        "2") Transaction_type="Płatność gotówką";;
        "3") Transaction_type="Płatność inną walutą";;
        *) return 3
    esac

    Transaction_UserID=$USER
    Transaction_CarID=$Car_ID
    Transaction_sum=$Car_price
    Transaction_currency=$Car_currency
    Transaction_date=$(date)
    Transaction_title="Zakup samochodu - ${Car_brand} $Car_name"

    db_save Car $1
    db_save Transaction
    title="REZULTAT TRANSAKCJI"
    return 0
}
