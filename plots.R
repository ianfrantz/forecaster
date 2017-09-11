#Plotting files
library(ggplot2)
#Simulation tial #1 (52 weeks, 1 sale per week)
y <- Simulator(52, p1t1[4], 1, p1t1[5])
x <- 1:52

#trial1 results for 1st Simulator with proportional barchart
trial1 <- data.frame(x,y)

productplot1 <- ggplot(data = trial1) +
  geom_bar(aes(x = y, y = ..prop..), fill = "red")

productplot1

productplot1 <- ggplot(data = trial1) +
  geom_bar(aes(x = y), fill = "red")

productplot1

#trial #2 (52 weeks, 5 sales per week)
y <- Simulator(52, p1t1[4], 5, p1t1[5])
trial2 <- data.frame(x,y)


#Think about how to color the offer numbers into this view. I think it will be more useful with showing the proportionality.

trialresults <-ggplot() + 
  geom_bar(data=trial1, aes(y), fill="red") + 
  geom_bar(data=trial2, aes(y), fill="blue")

trialresults

#Plot Densities for trial1 and trial2
require(reshape2)
df.m <- melt(data.frame(trial1 = trial1, trial2 = trial2))

productplot1 <- ggplot(df.m) +
  geom_density(aes(x = value, colour = variable)) + 
  labs(x = NULL)

productplot1 <- ggplot(data = c(trial1, trial2)) + 
  geom_point(mapping = aes(x=x, y=y, color = "blue"))


