#Plotting files
library(ggplot2)
#Siulation tial #1
y <- Simulator(52, p1t1[4], 1, p1t1[5])
x <- 1:52

#trial1 results for 1st Simulator
trial1 <- data.frame(x,y)

#trial #2
x <- Simulator(52, p1t1[4], 1, p1t1[5])
trial2 <- data.frame(x,y)

#Barchart showing proportional results
productplot1 <- ggplot(data = trial1) +
  geom_bar(aes(x = y, y = ..prop..), fill = "red")
#Think about how to color the offer numbers into this view. I think it will be more useful with showing the proportionality. 

productplot1

productplot1 <- ggplot(data = trial1) +
  geom_bar(mapping = aes(x = y, color = "red"))

productplot1

#Plot for trial1 and trial2
require(reshape2)
df.m <- melt(data.frame(trial1 = trial1, trial2 = trial2))

productplot1 <- ggplot(df.m) +
  geom_density(aes(x = value, colour = variable)) + 
  labs(x = NULL)



productplot1 <- ggplot(data = c(trial1, trial2)) + 
  geom_point(mapping = aes(x=x, y=y, color = "blue"))


