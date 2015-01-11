source("../lib/variability.R", chdir=T)

vvv_set("gender", "male")

INPUT <- "../data/c-%{gender}"
c <- readLines(vvv(INPUT))

gender <- vvv("gender")
result <- c(c, gender)

OUTPUT <- "../data/d-%{gender}"
writeLines(result, vvv(OUTPUT))

# OUTPUT: ../data/d-%{gender}
