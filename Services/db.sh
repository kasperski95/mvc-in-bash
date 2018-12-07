#!/bin/bash
source ./config.sh

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

db_save() {
    local modelName="$1"
    local id="$2"

    # find next id if not defined
    if [ "$id" == "" ]; then
        id=$(db_getLastId "$modelName")
        ((id++))
    fi

    # extract keys
    local keys
    while read -r key; do
        keys+=("$key")
    done < "./Models/$modelName.shm"

    # get values using eval
    local values
    for key in ${keys[@]}; do
        if [ "$key" == "ID" ]; then
            values+=("$id")
        else
            values+=("$(eval echo \$$modelName\_$key)")
        fi
    done

    # output to file
    local file="$DB/$modelName/$id.$DB_EXT"
    > $file
    for i in ${!keys[@]}; do
        echo "${keys[$i]}:${values[$i]}" >> $file
    done
}


db_import() {
    local modelName="$1" 
    local id="$2"

    # extract keys
    local key value
    while read -r line; do    
        eval "${modelName}_${line%:*}=\"${line#*:}\""
    done < "$DB/$modelName/$id.$DB_EXT"
}


db_remove() {
    local modelName="$1" 
    local id="$2"

    rm "$DB/$modelName/$id.$DB_EXT"
}

db_getAllKeys() {
    while read -r key; do
        echo "$key"
    done < "./Models/$modelName.shm"
}

db_getLastId() {
    db_getAll $1 | tail -n 1
}


db_getAll() {
    ls $DB/$1/ | sort -n | sed "s/.$DB_EXT//"
}