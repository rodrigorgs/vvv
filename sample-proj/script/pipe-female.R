# Configuration: {"gender"=>"female"}
source("../lib/variability.R", chdir=T)

# SCRIPT: pipe-%{gender}.R

# TODO: replace by a pattern, such as ../data/b-%{gender}
# INPUT: ../data/c-female
input = paste0("../data/c-", "female")
c <- readLines(input)

gender <- "female"
result <- c(c, gender)

output_filename <- paste0("../data/d-", gender)
writeLines(result, output_filename)

# OUTPUT: ../data/d-female
