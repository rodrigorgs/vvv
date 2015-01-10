source("../lib/variability.R", chdir=T)

vvv_set("gender", "male")

# SCRIPT: fork-%{gender}.R

INPUT <- "../data/b"
b <- readLines(vvv(INPUT))

gender <- vvv_get("gender")
result <- c(b, gender, b)

OUTPUT <- "../data/c-%{gender}"
writeLines(result, vvv(OUTPUT))
