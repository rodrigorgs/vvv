source("../lib/variability.R", chdir=T)

vvv_set("gender", "male")

vvv_input <- "../data/b"
b <- readLines(vvv_eval(vvv_input))

gender <- vvv_eval("%{gender}")
result <- c(b, gender, b)

vvv_output <- "../data/c-%{gender}"
writeLines(result, vvv_eval(vvv_output))
