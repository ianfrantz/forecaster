#-----Make sure forecaster is set as working directory-----
library(RSQLite) #For SQLite
library(glue) #For glue_sql and INSERT statements

#Read Data-----
#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="./Database/forecaster.db")

#Create hierarchy and producttable data.frames from tables in forecaster.db
hierarchy <- dbGetQuery(forecaster.db, "SELECT * FROM coreproducts")

product.table <- dbGetQuery(forecaster.db, 
          "SELECT product_name, tier_name, offer_number, price, probability
           FROM coreproducts 
           JOIN pricing USING (product_id)
           ORDER BY product_name, tier_name;")

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
  glue_sql("INSERT INTO results (date, time, trial_name, result) 
    VALUES ({paste(Sys.Date())*},
    {format(Sys.time(),'%X')*},
    'p1t1',
    {sum(sim1)*})",
    .con = forecaster.db)
)

#Close database connection
dbDisconnect(forecaster.db)

