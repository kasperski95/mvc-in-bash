#!/bin/bash

source ./Controllers/homeController.sh

# 0. Define db_create
# 1. Init db in ORM
# 2. Define db_read
# 3. importModel in ORM
# 4. Display
# 5. Commit
# 6. Define db_delete
# 7. Define db_update{db_delete && db_create}
# 8. Commit

# run
userID=0
while true; do
    home_index;
done;

exit 1