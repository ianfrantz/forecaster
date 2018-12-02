---
title: "READ ME"
author: "Ian Frantz (www.ianfrantz.com)"
output:
  html_document:
    df_print: paged
  word_document: default
date modified: December 1, 2018
---

# Forecaster
### License: MIT
### Written by: Ian Frantz - [www.ianfrantz.com](http://www.ianfrantz.com)

# Build Information:

Component   | Release
------------- | ------------- 
Database | V1.0
Source Code | V1.0
Shiny | Beta
Docuemtation | V1.0


# Forecaster is a sampling distribution tool for hierarchical sales analysis.

***

### Workflow:
  

# If you want to run this program yourself then follow the HowTo. 

* How To
  + [Set-up Excel](https://github.com/ianfrantz/forecaster/blob/master/Documentation/HowTo%20-%20Excel.Rmd)
  + [Create SQLite Database and Tables] ()
* SQLite 
  + forecaster.db
* Source Code 
  + 1. Read From SQLite.R
  + 2. Define Functions.R
  + 3. Simulation.R
  
# Data is stored in lists for rapid iteration:

```{r echo=FALSE, error=TRUE} 
source("./Source Code/2. Define Functions.R")
load(file = "./Data/product.table.RData")
p1t1 <- ProductList(product.table, "Product 1", "Tier 1")
p1t1
```

# Results of simulation for Product 1, Tier 1 with one attempt at a sale per day for 52 weeks.

```{r} 
sim1 <- Simulator(52, p1t1[4], 1, p1t1[5])
sim1
sum(sim1)
```

### Sample code for two plots side by side
```{r out.width=c('50%', '50%'), fig.show='hold'}
boxplot(1:10)
plot(rnorm(10))
```
# Example of a figure with a caption.
```{r, fig.align="center", fig.width=6, fig.height=6, fig.cap="Example of a caption."}

library(tidyverse)
mpg %>%
  ggplot( aes(x=reorder(class, hwy), y=hwy, fill=class)) + 
    geom_boxplot() +
    xlab("class") +
    theme(legend.position="none")
```