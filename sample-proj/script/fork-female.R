# Configuration: {"gender"=>"female"}
source("../lib/variability.R", chdir=T)

# SCRIPT: fork-%{gender}.R

# INPUT: ../data/b
b <- readLines("../data/b")

gender <- "female"
result <- c(b, gender, b)

output_filename <- paste0("../data/c-", gender)
writeLines(result, output_filename)

# OUTPUT: ../data/c-female
