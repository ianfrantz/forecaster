---
title: "READ ME"
author: "Ian Frantz (www.ianfrantz.com)"
date modified: December 1, 2018
output: word_document
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

### Workflow:
Excel data into SQLite and then into R for analysis, plotting and report generation. There are two new functions I wrote: Simulator and ProductList.  

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

