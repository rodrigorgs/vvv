source("../lib/variability.R", chdir=T)

vvv_set("gender", "male")

vvv_input <- "../data/c-%{gender}"
c <- readLines(vvv_eval(vvv_input))

gender <- vvv_eval("%{gender}")
result <- c(c, gender)

vvv_output <- "../data/d-%{gender}"
writeLines(result, vvv_eval(vvv_output))

# vvv_output: ../data/d-%{gender}
