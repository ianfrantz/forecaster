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

#Define simulator function

simulator <- function(samplesize, price, probability) {
  output <- c ()
  for (i in 1:52)
  {
    simulation <- pmap(list(x = price, size = samplesize, replace = TRUE, prob = probability), sample)
    output <- append(output, sum(simulation[[1]]))
  }
  output
}

#test 2

