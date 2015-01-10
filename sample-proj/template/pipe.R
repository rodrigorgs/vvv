source("../lib/variability.R", chdir=T)

# SCRIPT: pipe-%{gender}.R

INPUT <- "../data/c-%{gender}"
c <- readLines(vvv(INPUT, 'male'))

gender <- vvv("gender", "male")
result <- c(c, gender)

OUTPUT <- "../data/d-%{gender}"
writeLines(result, vvv(OUTPUT, 'male'))

# OUTPUT: ../data/d-%{gender}
