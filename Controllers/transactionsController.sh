#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User ${User_ID}


transactions_index() {
    title="EKSPORTUJ FAKTURĘ"
    ui_header "${title}"
    
    local Transactions
    for i in $(db_getAll Transaction); do
        db_import Transaction $i
        if [ $Transaction_UserID == $User_ID ]; then
            Transactions+=("$Transaction_ID")
        fi
        
    done
    ui_list Transaction transaction_listElement "${Transactions[@]}"
    
    transactions_handle $?
    
    return $?
}


transactions_handle() {
    if [ "$1" == "0" ]; then
        return 3
    fi
    
    db_import Transaction $1
    ui_header "${Transaction_ID}"
    
    echo "<details to be printed>"
    
    return 1
}