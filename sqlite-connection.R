#Build connection to SQLite database 

library(RSQLite)
library(dplyr)

setwd ("C:/Users/ianfr/Desktop/R Programs/forecaster")

#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="forecaster.db")


#Create hierarchy and producttable data.frames from tables in forecaster.db
hierarchy <- dbGetQuery(forecaster.db, "SELECT * FROM coreproducts")

product.table <- dbGetQuery(forecaster.db, 
          "SELECT product_name, tier_name, offer_number, price, probability
           FROM coreproducts JOIN pricing USING (product_id)
           ORDER BY product_name, tier_name;")

#Close database connection
dbDisconnect(forecaster.db)

#Build a "Product 1" and "Tier 1" list
p1t1 <- filter (product.table, product_name == "Product 1") %>% 
  filter (tier_name == "Tier 1") %>%
  list()


