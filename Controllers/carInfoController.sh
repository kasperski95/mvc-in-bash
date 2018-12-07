#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User $User_ID



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
    ui_list Car car_simpleListElement "${Cars[@]}"
        
    carInfo_handle $?

    return $?
}


carInfo_handle() {    
    if [ "$1" == "0" ]; then
        return 3
    fi

    db_import Car $1
    ui_header "$Car_brand"

    echo "Cena: $Car_price $Car_currency"
    echo "Przebieg: $Car_mileage km"

    return 1
}