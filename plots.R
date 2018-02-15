#Plotting files
library(ggplot2)
#Simulation tial #1 (52 weeks, 1 sale per week)
y <- Simulator(52, p1t1[4], 1, p1t1[5])
lx <- length(y)
x <- 1:lx

#trial1 results
trial1 <- data.frame(x,y)

trial1plot <- ggplot(data = trial1) 

#--FUTURE--Sum trial1$y and put results into labels
trial1plot + 
  geom_bar(aes(x = y), fill = "green") + 
  labs(
    title = "Title: Fuel efficiency generally decreases with engine size",
    subtitle = "Subtitle: Two seaters (sports cars) are an exception because of their light weight",
    caption = "Caption: Data from fueleconomy.gov"
  )

trial1plot + 
  geom_bar(aes(x = y, y = ..prop..), fill = "green") 


#trial #2 (52 weeks, 5 sales per week)
y <- Simulator(52, p1t1[4], 5, p1t1[5])
lx <- length(y)
x <- 1:lx
trial2 <- data.frame(x,y)

trial2plot <- ggplot(data = trial2) 

trial2plot + 
  geom_bar(aes(x = y), fill = "red")


#Think about how to color the offer numbers into this view. I think it will be more useful with showing the proportionality.

combineresults <- ggplot() + 
  geom_bar(data=trial1, aes(y), fill="green") + 
  geom_bar(data=trial2, aes(y), fill="red")

combineresults

#Plot Densities for trial1 and trial2
require(reshape2)
df.m <- melt(data.frame(trial1 = trial1, trial2 = trial2))

trial1 <- ggplot(df.m) +
  geom_density(aes(x = value, colour = variable)) + 
  labs(x = NULL)

trial1

trial1 <- ggplot(data = c(trial1, trial2)) + 
  geom_point(mapping = aes(x=x, y=y, color = "red"))



