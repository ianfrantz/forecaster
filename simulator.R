library (purrr)

#Define simulator function
#Default simulation is set to sales per week

#The "Simulator" function is defined here with three variables.
Simulator <- function(weeks, price, samplesize, probability) {
  output <- c ()
  for (i in 1:weeks)
  {
    simulation <- pmap(list(x = price, size = samplesize, replace = TRUE,  prob = probability), sample)
    output <- append(output, sum(simulation$price))
  }
  return(output)
}

#Simulating 52 weeks and 1 sale per week.
Simulator(52, p1t1[4], 1, p1t1[5])

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
