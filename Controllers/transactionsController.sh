#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${USER_ID}


transactions_index() {
    title="FAKTURY"
    ui_header "${title}"
    
    local Transactions
    for i in $(db_getAll Transaction); do
        db_import Transaction $i
        if [ $Transaction_UserID == $User_ID ]; then
            Transactions+=("$Transaction_ID")
        fi
        
    done
    ui_list Transaction ui_transaction "${Transactions[@]}"
    
    transactions_handle $?
    
    return $?
}


transactions_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Transaction $1
    
    ui_header "Faktura nr ${Transaction_ID}"
    
    echo "Tytuł: $Transaction_title"
    echo "Data: $Transaction_date"
    db_import User $DEALER
    echo "Wystawił: $User_firstname $User_lastname"
    db_import User $Transaction_UserID
    echo "Odbiorca: $User_firstname $User_lastname"
    echo "Kwota: $Transaction_sum $Transaction_currency"
    echo ""

    ui_actions "Eksportuj"

    if [ "$?" == "1" ]; then
        title="EKSPORT: faktura_$Transaction_ID.txt"
    
        if [ ! -d "./Exports" ]; then
            mkdir "./Exports"
        fi

        file="./Exports/faktura_$Transaction_ID.txt"
        echo "Tytuł: $Transaction_title" > $file
        echo "Data: $Transaction_date" >> $file
        db_import User $DEALER 
        echo "Wystawił: $User_firstname $User_lastname" >> $file
        db_import User $Transaction_UserID
        echo "Odbiorca: $User_firstname $User_lastname" >> $file
        echo "Kwota: $Transaction_sum $Transaction_currency" >> $file
        return 0
    fi

    return 3
}