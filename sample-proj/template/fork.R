source("../lib/variability.R", chdir=T)

# SCRIPT: fork-%{gender}.R

INPUT <- "../data/b"
b <- readLines(vvv(INPUT))

gender <- vvv("gender", "male")
result <- c(b, gender, b)

OUTPUT <- "../data/c-%{gender}"
writeLines(result, vvv(OUTPUT, "male"))

# OUTPUT: ../data/c-%{gender}
