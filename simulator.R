#-----library (purrr) #For use of `pmap`` in the Simulator function-----
library (dplyr) #Use of dplyr package in ProductList function


#-----Functions "Simulator" and "ProductList"------

#The "Simulator" function is defined here taking four variables. 
  #-weeks: the number of weeks
  #-price: product hierarchical pricing
  #-samplesize: the number of sampling distributions
  #-probability: pdf - density function
Simulator <- function(weeks, price, samplesize, probability) {
  output <- c ()
  for (i in 1:weeks)
  {
    simulation <- purrr::pmap(list(x = price, size = samplesize, replace = TRUE,  prob = probability), sample)
    output <- append(output, sum(simulation$price))
  }
  return(output)
}


#The "ProductList" function is used to create lists based on "Product X" and "Tier X" data.frames 
ProductList <- function(product.table, product_name1, tier_name1) {
  dplyr::filter (product.table, product_name1 == product_name, 
          tier_name1 == tier_name) %>% as.list() }

