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
        if [ $Car_UserID == 1 ]; then
            Cars+=("$Car_brand")
        fi
    done
    ui_actions "${Cars[@]}"
    
    buy_handle $?
    
    return $?
}


buy_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Car $1
    ui_header "SPOSÓB ZAPŁATY ZA: ${Car_brand}"
    
    ui_actions "Karta" "Gotówka" "Inna waluta"

    case "$?" in
        "1") Transaction_type="Zapłacono kartą";;
        "2") Transaction_type="Zapłacono gotówką";;
        "3") Transaction_type="Zapłacono inną walutą";;
    esac
    Transaction_UserID=$User_ID
    Transaction_CarID=$Car_ID

    db_save Transaction
    return 0
}
