#-----Creating ProductLists-----
#Create results lists using the ProductList function
p1t1 <- ProductList(product.table, "Product 1", "Tier 1")
p1t2 <- ProductList(product.table, "Product 1", "Tier 2")
p2t1 <- ProductList(product.table, "Product 2", "Tier 1")
p3t1 <- ProductList(product.table, "Product 3", "Tier 1")
p3t2 <- ProductList(product.table, "Product 3", "Tier 2")
s1t1 <- ProductList(product.table, "Service 1", "Tier 1")

#-----Default simulation-----
#Simulating 52 weeks and 1 sale per week.
sim1 <- Simulator(52, p1t1[4], 1, p1t1[5])
sim1
sum(sim1)

