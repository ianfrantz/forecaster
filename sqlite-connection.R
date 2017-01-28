#Build connection to SQLite database 

library(RSQLite)

setwd ("C:/Users/ianfr/Desktop/R Programs/forecaster")

#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="forecaster.db")


#Extract Data from forecaster.db
hierarchy <- dbGetQuery(forecaster.db, "SELECT * FROM product")

#dbList examples:
dbListTables(forecaster.db) #All tables
dbListFields(forecaster.db, "product") #Fields in a table
