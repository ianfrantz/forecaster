#-----Make sure forecaster is set as working directory-----
library(RSQLite) #For SQLite

#-----Read Data From forecaster.db-----
#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="../Database/forecaster.db")

#Create hierarchy and producttable data.frames from tables in forecaster.db
hierarchy <- dbGetQuery(forecaster.db, "SELECT * FROM coreproducts")

product.table <- dbGetQuery(forecaster.db, 
          "SELECT ProductName, TierName, OfferNumber, Price, Probability
           FROM coreproducts 
           JOIN pricing USING (ProductId)
           ORDER BY ProductName, TierName;")

#Close database connection
dbDisconnect(forecaster.db)
rm (forecaster.db)

#Save product.table for Shiny
save (product.table, file = "./Shiny/product.table.RData")

