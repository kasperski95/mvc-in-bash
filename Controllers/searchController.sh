#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Controllers/carInfoController.sh
source ./Services/db.sh
db_import User ${USER}


search_index() {
    title="SZUKAJ PO MARCE"
    ui_header "${title}"
    
    local brand
    read -p "Marka: " brand 
    echo ""

    local Cars
    for i in $(db_getAll Car); do
        db_import Car $i
        if [ $Car_UserID == $DEALER ] && [ $Car_reservedByUserID == $DEALER ] && [ "$Car_brand" == "$brand" ]; then
            Cars+=("$Car_ID")
        fi
    done
    
    ui_list Car ui_car "${Cars[@]}"
    
    carInfo_handle $?
    
    return $?
}