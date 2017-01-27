#!/bin/bash
cd /mnt/c/Users/ianfr/Desktop/R\ Programs/forecaster/

echo "Build SQLite product table? (Y/N)"

read product 

#Use globbing to see if a yY was entered
if [[ $product == *[yY]* ]]; then

#Initialize Product Simulation Database (forecaster.db)
sqlite3 forecaster.db << EOF
.headers on
CREATE TABLE product (
product_id INTEGER PRIMARY KEY,
product_name TEXT,
parent INTEGER);
EOF

else
echo "Product table NOT built"
fi

#Import Data into "product" table.
echo "Import data into product?"
read import1
if [[ $import1 == *[yY]* ]]; then

#Initialize sqlite3 for import and read product.csv

