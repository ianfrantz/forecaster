#Build connection to SQLite database 

library(RSQLite)

setwd ("C:/Users/ianfr/Desktop/R Programs/forecaster")

#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="forecaster.db")


#Extract Data from forecaster.db
hierarchy <- dbGetQuery(forecaster.db, "SELECT * FROM coreproducts")

#dbList examples:
dbListTables(forecaster.db) #All tables


producttable <- dbGetQuery(forecaster.db, 
          "SELECT product_name, tier_name, offer_number, price, probability
           FROM coreproducts JOIN pricing USING (product_id)
           ORDER BY product_name, tier_name;")
