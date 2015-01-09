a <- readLines("../raw-data/a")

b <- paste0(a, a)

writeLines(b, "../data/b")
