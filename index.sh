#!/bin/bash

source ./config.sh

if [ ! -d "$DB" ]; then
    source ./mock.sh
fi

source ./Controllers/homeController.sh

while true; do
    home_index;
done;

exit 1