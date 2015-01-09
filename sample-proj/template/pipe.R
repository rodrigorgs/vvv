source("../lib/variability.R", chdir=T)

# SCRIPT: pipe-%{gender}.R

# TODO: replace by a pattern, such as ../data/b-%{gender}
# INPUT: ../data/c-%{gender}
input = paste0("../data/c-", vvv("gender", "male"))
c <- readLines(input)

gender <- vvv("gender", "male")
result <- c(c, gender)

output_filename <- paste0("../data/d-", gender)
writeLines(result, output_filename)

# OUTPUT: ../data/d-%{gender}
