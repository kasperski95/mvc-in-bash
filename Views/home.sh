#!/bin/bash

source ./Views/UI/atoms.sh
source ./Views/UI/molecules.sh

home_view() {
    ui_header "$1" && shift 1

    local i=1;
    while [ "$#" -gt "0" ]; do
        echo "$i - $1" && shift 1
    done

    ui_footer
    return $?
}