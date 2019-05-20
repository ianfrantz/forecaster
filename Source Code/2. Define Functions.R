#-----Load library (dplyr)-----
#purrr::pmap used in the Simulator function
library (dplyr) #Use of dplyr package in ProductList function

#-----Functions "Simulator" and "ProductList"------

#The "Simulator" function takes four variables. 
  #'*weeks*: the number of weeks
  #'*price*: product hierarchical pricing
  #'*samplesize*: the number in the sampling distribution
  #'*probability*: probability density function
Simulator <- function(weeks, price, samplesize, probability) {
  output <- c ()
  for (i in 1:weeks)
  {
    simulation <- purrr::pmap(list(x = price, size = samplesize, replace = TRUE,  prob = probability), sample)
    output <- append(output, sum(simulation$Price))
  }
  return(output)
}


#The "ProductList" function is used to create lists based on "Product X" and "Tier X" data.frame
ProductList <- function(product.table, product_name, tier_name) {
  dplyr::filter (product.table, product_name == ProductName, 
          tier_name == TierName) %>% as.list() }

