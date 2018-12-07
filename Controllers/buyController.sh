#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${User_ID}


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
    ui_list Car car_simpleListElement "${Cars[@]}"
    
    buy_handle $?
    
    return $?
}


buy_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    Car_UserID=$User_ID
    Car_reservedByUserID=$User_ID
    db_save Car $1
    
    ui_header "SPOSÓB ZAPŁATY ZA: ${Car_brand}"
    
    ui_actions "Karta" "Gotówka" "Inna waluta"

    case "$?" in
        "1") Transaction_type="Płatność kartą";;
        "2") Transaction_type="Płatność gotówką";;
        "3") Transaction_type="Płatność inną walutą";;
        *) return 3
    esac
    Transaction_UserID=$User_ID
    Transaction_CarID=$Car_ID
    Transaction_sum=$Car_price
    Transaction_currency=$Car_currency
    Transaction_date=$(date)
    Transaction_title="Zakup samochodu - ${Car_brand}"
    db_save Transaction
    return 0
}
