#!/bin/bash

if [ -d "./Database" ]; then
    rm -r "./Database"
fi

source ./Services/db.sh

User_firstname="John"
User_lastname="Doe"
User_money="10000"
User_currency="PLN"
db_save User