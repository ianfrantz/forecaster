#Create Lists for Each Product, Service and Tier-----

#ProductList creates independent lists for each cobmination of Product, Service and Tier.
p1t1 <- ProductList(product.table, "Product 1", "Tier 1")
p1t2 <- ProductList(product.table, "Product 1", "Tier 2")
p2t1 <- ProductList(product.table, "Product 2", "Tier 1")
p3t1 <- ProductList(product.table, "Product 3", "Tier 1")
p3t2 <- ProductList(product.table, "Product 3", "Tier 2")
s1t1 <- ProductList(product.table, "Service 1", "Tier 1")

#-----Default simulation-----
#Simulating 52 weeks, p1t1[price range], 1 sale per week, p1t1[probability of price range]
sim1 <- Simulator(52, p1t1[4], 1, p1t1[5])
sim1
sum(sim1)
str(sim1)
#Same Simulation for sim2
sim2 <- Simulator(52, p1t2[4], 1, p1t2[5])
sim2
sum(sim2)
