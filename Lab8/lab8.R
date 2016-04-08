library(arules)
library(arulesViz)
str(admissions)
col_names <- names(admissions)
admissions[,col_names] <- lapply(admissions[,col_names], factor)
summary(admissions)
rules <- apriori(admissions, control = list(verbose=F),
                 parameter = list(minlen=2, supp=0.015, conf=0.5),
                 appearance = list(rhs = c("admit=1", "admit=0"),
                                   default="lhs"))
rules <- sort(rules, by="support")
subset.matrix <- is.subset(rules, rules)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
rules <- rules[!redundant]
inspect(rules)
plot(rules, method="grouped")