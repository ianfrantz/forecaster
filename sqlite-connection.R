#Make sure forecaster is set as working directory
library(RSQLite) #For SQLite

#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="./Database/forecaster.db")

#Create hierarchy and producttable data.frames from tables in forecaster.db
hierarchy <- dbGetQuery(forecaster.db, "SELECT * FROM coreproducts")

product.table <- dbGetQuery(forecaster.db, 
          "SELECT product_name, tier_name, offer_number, price, probability
           FROM coreproducts JOIN pricing USING (product_id)
           ORDER BY product_name, tier_name;")

#Close database connection
dbDisconnect(forecaster.db)
rm (forecaster.db)

#Save product.table
<<<<<<< HEAD
setwd ("C:/Users/ianfr/Desktop/R_Programs/forecaster/Data")
save (product.table, file = "product.table.RData")
=======
save (product.table, file = "./Data/product.table.RData")
>>>>>>> Sprint1.4_plotting
