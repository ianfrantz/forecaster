#Write Results of Analysis.R to SQLite-----
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