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
