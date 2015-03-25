vvv_input <- "../raw-data/a"
a <- readLines(vvv_input)

b <- paste0(a, a)

vvv_output <- "../data/b"
writeLines(b, vvv_output)
