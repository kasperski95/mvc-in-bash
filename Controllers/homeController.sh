#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Controllers/carInfoController.sh
source ./Controllers/buyController.sh
source ./Controllers/sellController.sh
source ./Controllers/reserveController.sh
source ./Controllers/unreserveController.sh
source ./Controllers/searchController.sh
source ./Controllers/testDriveController.sh
source ./Controllers/transactionsController.sh
source ./Services/db.sh
db_import User $USER_ID



home_index() {
    title="HOME"
    ui_header "$title"

    home_testDrives

    ui_actions\
        "Samochody"\
        "Kup"\
        "Sprzedaj"\
        "Rezerwuj"\
        "Odrezerwuj"\
        "Szukaj po marce"\
        "Jazda testowa"\
        "Faktury"

    home_handle $?
}


home_handle() {
    case "$1" in
        "1") carInfo_index;;
        "2") buy_index;;
        "3") sell_index;;
        "4") reserve_index;;
        "5") unreserve_index;;
        "6") search_index;;
        "7") testDrive_index;;
        "8") transactions_index;;
        "0") clear && exit 0;;
        *) setReturnValue 42;
    esac

    case "$?" in
        "0")
            ui_header "$title"
            echo "Operacja zakończyła się powodzeniem."
            ui_line
            read -n 1 -s -r -p "wciśnij dowolny klawisz aby wrócić do menu...";;
        "1")
            ui_line
            read -n 1 -s -r -p "wciśnij dowolny klawisz aby wrócić do menu...";;
        "2")
            ui_header "$title"
            echo "Operacja nie powiodła się."
            ui_line
            read -n 1 -s -r -p "wciśnij dowolny klawisz aby wrócić do menu...";;
    esac
}

setReturnValue() {
    return $1
}


home_testDrives() {
    local TestDrives
    for i in $(db_getAll TestDrive); do
        db_import TestDrive $i
        if [ $TestDrive_UserID == $USER_ID ]; then
            TestDrives+=("$TestDrive_ID")
        fi
    done

    if [ ${#TestDrives[@]} -gt 0 ]; then
        echo "Jesteś umówiony na jazdę testową:"
        for id in ${TestDrives[@]}; do
            db_import TestDrive $id
            db_import Car $TestDrive_CarID
            echo "$TestDrive_date - $Car_brand"
        done
        echo ""
    fi
}