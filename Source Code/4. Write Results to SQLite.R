#Write Results of Analysis.R to SQLite-----
library(glue) #For glue_sql and INSERT statements

#Connect to SQLite forecaster.db
forecaster.db <- dbConnect(SQLite(),dbname="../Database/forecaster.db")

#-----Insert Results-----
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
#-----Look at Results-----
dbGetQuery(forecaster.db,
            glue_sql("SELECT * 
                     FROM results",
                     .con = forecaster.db)
)

#'Create *dbreults* as a vector
dbresults <- dbGetQuery(forecaster.db,
                         glue_sql("SELECT * 
                                  FROM results",
                                  .con = forecaster.db)
)

#'*SAVE - dbresults* as an *Rdata* file
save (dbresults, file = "dbresults.Rdata")


#-----Close database connection-----
dbDisconnect(forecaster.db)
rm (forecaster.db)

#'Write () 