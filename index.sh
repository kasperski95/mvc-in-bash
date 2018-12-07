#!/bin/bash

if [ ! -d "./Database" ]; then
    source ./mock.sh
fi

source ./Controllers/homeController.sh

while true; do
    home_index;
done;

exit 1