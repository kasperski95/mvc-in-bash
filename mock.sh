#!/bin/bash

if [ -d "./Database" ]; then
    rm -r "./Database"
fi

source ./Services/db.sh

# USERS
User_firstname="Komis"
User_lastname="samochodowy"
db_save User

User_firstname="John"
User_lastname="Doe"
db_save User


# CARS
Car_UserID="1"
Car_currency="PLN"

Car_brand="Audi"
Car_price="10000"
Car_mileage="10000"
db_save Car

Car_brand="Volkswagen"
Car_price="12000"
Car_mileage="20000"
db_save Car

Car_brand="Opel"
Car_price="20000"
Car_mileage="30000"
db_save Car

Car_brand="Porsche"
Car_price="100000"
Car_mileage="80000"
db_save Car

Car_brand="Mercedes"
Car_price="120000"
Car_mileage="60000"
db_save Car

Car_brand="BMW"
Car_price="90000"
Car_mileage="40000"
db_save Car

Car_brand="Jaguar"
Car_price="200000"
Car_mileage="30000"
db_save Car

Car_brand="Aston"
Car_price="400000"
Car_mileage="80000"
db_save Car

Car_brand="Alfa Romeo"
Car_price="140000"
Car_mileage="60000"
db_save Car

Car_brand="Citroen"
Car_price="75000"
Car_mileage="40000"
db_save Car