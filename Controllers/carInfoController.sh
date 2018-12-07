#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User $USER_ID



carInfo_index() {
    title="SAMOCHODY"

    ui_header "$title"

    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $Car_UserID == $DEALER ] && [ $Car_reservedByUserID == $DEALER ]; then
            Cars+=("$Car_ID")
        fi
        
    done
    ui_list Car ui_car "${Cars[@]}"
        
    carInfo_handle $?

    return $?
}


carInfo_handle() {    
    if [ "$1" == "0" ]; then
        return 3
    fi

    db_import Car $1
    ui_header "INFORMACJE O SAMOCHODZIE: $Car_brand"

    echo "Cena: $Car_price $Car_currency"
    echo "Przebieg: $Car_mileage km"
    
    echo ""

    ui_actions "Eksportuj"
    if [ "$?" == "1" ]; then
        title="EKSPORT: samochod_$Car_ID.txt"
    
        if [ ! -d "./Exports" ]; then
            mkdir "./Exports"
        fi

        file="./Exports/samochod_$Transaction_ID.txt"
        echo "Cena: $Car_price $Car_currency" > $file
        echo "Przebieg: $Car_mileage km" >> $file
        return 0
    fi

    return 3
}