#!/bin/bash

DB="./Database"
DB_EXT="kas"

# create database directory if it doesn't exist
if [ ! -d $DB ]; then
    mkdir $DB
fi

# create "table" for every model
for filename in ./Models/*.shm; do
    name=$(basename $filename)
    name=${name%.*}
    if [ ! -d $DB/$name ]; then
        mkdir $DB/$name
    fi
done

#-------------------------------------------------------------

db_create() {
    local modelName=$1
    local id=$2

    # extract keys
    local keys
    while read -r key; do
        keys+=("$key")
    done < "./Models/$modelName.shm"

    # get values using eval
    local values
    for i in ${keys[@]}; do
        values+=($(eval echo \$$i))
    done

    # create directory if necessary
    if [ ! -d "$DB/$modelName" ]; then
        id=0
        mkdir "$DB/$modelName"
    else
        # find next id if not defined
        if [ ! -z ${id+x} ]; then
            id=$(_db_getNewId "$DB/$modelName")
        fi
    fi

    # output to file
    local file="$DB/$modelName/$id.$DB_EXT"
    > $file
    for i in ${!keys[@]}; do
        echo "${keys[$i]}:${values[$i]}" >> $file
    done
}

db_read() {
    echo "not implemented!"
}

db_update() {
    echo "not implemented!"
}

db_delete() {
    echo "not implemented!"
}

#-------------------------------------------------------------


_db_getNewId() {
    echo "0"
    return 0
    local dir=$1
    ls $dir | sort -g
}