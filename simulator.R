library (purrr) #For use of `pmap`` in the Simulator function
library (dplyr) #Needed `filter`` in ProductList function

#-----Functions "Simulator" and "ProductList"------

#The "Simulator" function is defined here with four variables.
Simulator <- function(weeks, price, samplesize, probability) {
  output <- c ()
  for (i in 1:weeks)
  {
    simulation <- pmap(list(x = price, size = samplesize, replace = TRUE,  prob = probability), sample)
    output <- append(output, sum(simulation$price))
  }
  return(output)
}


#The "ProductList" function is used to create lists based on "Product X" and "Tier X" data.frames 
ProductList <- function(product_name1, tier_name1) {
  filter (product.table, product_name1 == product_name, 
          tier_name1 == tier_name) %>% as.list() }


#-----Creating ProductLists-----
#Create results lists using the ProductList function
p1t1 <- ProductList("Product 1", "Tier 1")
p1t2 <- ProductList("Product 1", "Tier 2")
p2t1 <- ProductList("Product 2", "Tier 1")

#-----Default simulation-----
#Simulating 52 weeks and 1 sale per week.
sim1 <- Simulator(52, p1t1[4], 1, p1t1[5])
sim1
sum(sim1)
