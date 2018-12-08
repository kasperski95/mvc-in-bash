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
Car_reservedByUserID="1"
Car_power="250"
Car_fuelUsage="7"
Car_acceleration="7"
Car_body="Sedan"
Car_length="4915"
Car_width="1900"
Car_bootVolume="400"

Car_brand="Audi"
Car_name="A6"
Car_year="2009"
Car_price="41000"
Car_mileage="285000"
db_save Car

Car_brand="Audi"
Car_name="A4"
Car_year="2010"
Car_price="36800"
Car_mileage="218000"
db_save Car

Car_brand="Opel"
Car_name="Astra"
Car_year="2011"
Car_price="26900"
Car_mileage="98000"
db_save Car

Car_brand="Porsche"
Car_name="Panamera"
Car_year="2012"
Car_price="158600"
Car_mileage="205000"
db_save Car

Car_brand="BMW"
Car_name="Seria 5"
Car_year="2013"
Car_price="95000"
Car_mileage="173000"
db_save Car

Car_brand="BMW"
Car_name="X1"
Car_year="2014"
Car_price="79500"
Car_mileage="128400"
db_save Car

Car_brand="BMW"
Car_name="Seria 3"
Car_year="2015"
Car_price="61500"
Car_mileage="95000"
db_save Car

Car_brand="Aston"
Car_name="V12 Vanquish"
Car_year="2016"
Car_price="624000"
Car_mileage="14300"
db_save Car

Car_brand="Alfa Romeo"
Car_name="Giulia"
Car_year="2017"
Car_price="88899"
Car_mileage="25000"
db_save Car

Car_brand="Citroen"
Car_name="C3"
Car_year="2018"
Car_price="55000"
Car_mileage="1900"
db_save Car