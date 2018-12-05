#!/bin/bash

source ./Services/db.sh
#source ./Models/User.shm


home_index() {
    echo "home_index..."
    firstname="John"
    lastname="Doe"
    db_create "User"

    echo "$firstname"

    read -p "wciśnij dowolny klawisz aby kontynuować..."
}