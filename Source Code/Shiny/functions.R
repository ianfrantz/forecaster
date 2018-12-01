#-----Functions "Simulator" and "ProductList"------

#'-----*Simulator* function-----
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

#'-----*ProductList* Function------
#The "ProductList" function is used to create lists based on "Product X" and "Tier X" data.frame
ProductList <- function(product.table, product_name, tier_name) {
  dplyr::filter (product.table, product_name == ProductName, 
                 tier_name == TierName) %>% as.list() }

#'-----*return_tooltip* Function-----
#-----Defines hover-----
return_tooltip <- function(hover, point){
  left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
  top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
  
  # calculate distance from left and bottom side of the picture in pixels
  left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
  top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
  
  style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                  "left:", left_px + 2, "px; top:", top_px + 2, "px;")
  
  output_string <- ''
  
  point2 <- as.list(point)
  
  for(i in 1:length(point2)){
    output_string <- paste0(output_string, "<b>", names(point2[i]), "</b>: ", as.character(point2[i]), "<br>")
  }
  
  # actual tooltip created as wellPanel
  return(list(output_string=output_string, style=style))
  
}
