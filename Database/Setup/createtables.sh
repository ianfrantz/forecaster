#!/bin/bash
cd /c/Users/ianfr/Desktop/R_Programs/forecaster/Database

echo "Build SQLite coreproducts table? (Y/N)"

read coreproducts 

#Use globbing to see if a yY was entered
if [[ $coreproducts == *[yY]* ]]; then

#Initialize forecaster.db and import build coreproducts table
sqlite3 forecaster.db << EOF
CREATE TABLE coreproducts (
ProductId INTEGER NOT NULL PRIMARY KEY,
ProductName TEXT);
EOF

else
echo "Coreproducts table NOT built"
fi

#Import Data into "coreproducts" table.
echo "Import data into coreproducts?"
read importcore
if [[ $importcore == *[yY]* ]]; then

#Initialize sqlite3 for import and read coreproducts.csv
sqlite3 forecaster.db << EOF
.mode csv
.import ./Setup/coreproducts.csv coreproducts
EOF

else
echo "Product data NOT imported"
fi

#Build pricing table
echo "Create pricing table? (Y/N)"

read pricing

#Use globbing to see if a yY was entered
if [[ $pricing == *[yY]* ]]; then

sqlite3 forecaster.db << EOF
CREATE TABLE pricing (
PricingId INTEGER NOT NULL PRIMARY KEY,
TierName TEXT,
OfferNumber INTEGER,
Price INTEGER,
Probability REAL,
ProductId INTEGER NOT NULL REFERENCES coreproducts);
EOF

else
echo "Pricing table NOT built"
fi

#Import Data into "pricing" table.
echo "Import data into pricing?"
read importpricing
if [[ $importcore == *[yY]* ]]; then

#Initialize sqlite3 for import and read coreproducts.csv
sqlite3 forecaster.db << EOF
.mode csv
.import ./Setup/pricing.csv pricing
EOF

else
echo "Pricing data NOT imported"
fi 

#Create "results" table.
echo "Create results table?"
read createresults
if [[ $createresults == *[yY]* ]]; then

sqlite3 forecaster.db << EOF
CREATE TABLE results (
ResultId INTEGER NOT NULL PRIMARY KEY,
Date DATE,
Time TIME,
SimulationNumber TEXT,
Duration INTEGER,
Sales INTEGER,
Result INTEGER);
EOF

else
echo "Results table NOT built"
fi

#Import "results" data.
echo "Import data into results?"

read importresults
if [[ $importresults == *[yY]* ]]; then

#Initialize sqlite3 for import and read results.csv
sqlite3 forecaster.db << EOF
.mode csv
.import ./Setup/results.csv results
EOF

else
echo "Results data NOT imported"
fi

