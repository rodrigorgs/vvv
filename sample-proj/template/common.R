INPUT <- "../raw-data/a"
a <- readLines(INPUT)

b <- paste0(a, a)

OUTPUT <- "../data/b"
writeLines(b, OUTPUT)
