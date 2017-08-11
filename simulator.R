library (purrr)

#Define simulator function
#Default simulation is set to sales per week

#The "Simulator" function is defined here with three variables.
Simulator <- function(samplesize, price, probability) {
  output <- c ()
  for (i in 1:52)
  {
    simulation <- pmap(list(size = samplesize, x = price, prob = probability, replace = TRUE ), sample)
    output <- append(output, sum(simulation[[1]]))
  }
  return(output)
}


#The "ProductList" function is used to create lists of already filtered "Product X" and "Tier X" data.frames 
ProductList <- function (prodtier, product) {
  pt.results <- c()
  for ( i in prodtier) {
    pt.results <- c(i, prodtier[[product]]) %>%
      as.list(product$product_name)
  }
  return(pt.results)  
}

#Creating a list using the ProductList function
product1 <- ProductList(p1t1, "price")

#Create results list


#Plot results:
plots <- pmap(p1t1, countries,
              ~ ggplot(.x, aes(year, lifeExp)) +
                geom_line() +
                labs(title = .y))
plots[[1]]
