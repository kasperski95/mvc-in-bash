#!/bin/bash

source ./config.sh
source ./Views/UI/index.sh
source ./Controllers/carInfoController.sh
source ./Controllers/buyController.sh
source ./Controllers/sellController.sh
source ./Controllers/reserveController.sh
source ./Controllers/searchController.sh
source ./Controllers/testDriveController.sh
source ./Controllers/transactionsController.sh
source ./Services/db.sh
db_import User $User_ID



home_index() {
    title="HOME"
    ui_header "$title"

    ui_actions\
        "Samochody"\
        "Kup"\
        "Sprzedaj"\
        "Rezerwuj"\
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
        "5") search_index;;
        "6") testDrive_index;;
        "7") transactions_index;;
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