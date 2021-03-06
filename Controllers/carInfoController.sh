#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Services/db.sh
db_import User $USER



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
    ui_header "INFORMACJE O SAMOCHODZIE: $Car_brand $Car_name"

    echo "Cena: $Car_price $Car_currency"
    echo "Rocznik: $Car_year"
    echo "Przebieg: $Car_mileage km"
    echo "Nadwozie: $Car_body"
    echo "Moc: $Car_power hp"
    echo "Zużycie paliwa na 100 km: ${Car_fuelUsage} l"
    echo "0-100 km/h: ${Car_acceleration} s"
    echo "Długość: $Car_length mm"
    echo "Szerokość: $Car_width mm"
    echo "Pojemność bagażnika: ${Car_bootVolume} l"
    echo ""

    ui_actions "Eksportuj"
    if [ "$?" == "1" ]; then
        title="EKSPORT: samochod_$Car_ID.txt"
    
        if [ ! -d "./Exports" ]; then
            mkdir "./Exports"
        fi

        file="./Exports/samochod_$Car_ID.txt"
        echo "Marka: $Car_brand" > $file
        echo "Model: $Car_name" >> $file
        echo "Cena: $Car_price $Car_currency" >> $file
        echo "Rocznik: $Car_year" >> $file
        echo "Przebieg: $Car_mileage km" >> $file
        echo "Nadwozie: $Car_body" >> $file
        echo "Moc: $Car_power hp" >> $file
        echo "Zużycie paliwa na 100 km: ${Car_fuelUsage} l"
        echo "0-100 km/h: ${Car_acceleration} s" >> $file
        echo "Długość: $Car_length mm" >> $file
        echo "Szerokość: $Car_width mm" >> $file
        echo "Pojemność bagażnika: $Car_bootVolume l" >> $file
        return 0
    fi

    return 3
}