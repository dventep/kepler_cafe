#! /bin/bash
echo "=========================== Help for psql ==========================="
echo "\\dt  : Describe the current database"
echo "\\d [table]   : Describe a table"
echo "\\c   : Connect to a database"
echo "\\h   : help with SQL commands"
echo "\\?   : Help with psql commands"
echo "\\q   : quit"
echo "===========================  ==========================="
docker exec -it postgres psql -U postgres -d kepler_db
