library (dplyr)
library (purrr)

#Create P1T1 dataframe with only "Product 1" and "Tier 1" data

P1T1 <- filter (producttable, product_name == "Product 1") %>% 
  filter (tier_name == "Tier 1")

P1T2 <- filter (producttable, product_name == "Product 1") %>%
  filter (tier_name == "Tier 2")

#Build lists for "Product 1" - "Tier 1"

p1t1price <- list(P1T1$price)
p1t1probability <- list (P1T1$probability)

#Ready variables for sample function
ssize <- 12
P1T1Forecast <- c()

for (i in 1:300)
{
  simulation <- pmap(list(x = p1t1price, size = ssize, replace = TRUE, prob = p1t1probability), sample)
  P1T1Forecast <- append(P1T1Forecast, sum(simulation[[1]]))
}
