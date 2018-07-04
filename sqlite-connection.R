#-----Make sure forecaster is set as working directory-----
library(RSQLite) #For SQLite
library(glue) #For glue_sql and INSERT statements

#Read Data-----
#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="./Database/forecaster.db")

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

#Save product.table
save (product.table, file = "./Data/product.table.RData")

#Write Results-----
#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="./Database/forecaster.db")

#Insert Results
dbSendQuery(forecaster.db,
  glue_sql("INSERT INTO results (Date, Time, SimulationNumber, Duration, Sales, Result) 
    VALUES ({paste(Sys.Date())*},
    {format(Sys.time(),'%X')*},
    'Sim1',
    '52 Weeks',
    '1 Sale Per Day',
    {sum(sim1)*})",
    .con = forecaster.db)
)

#Close database connection
dbDisconnect(forecaster.db)
rm (forecaster.db)

