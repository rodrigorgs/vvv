source("../lib/variability.R", chdir=T)

vvv_set("gender", "male")

# JOIN

INPUT <- "../data/d-%{gender}"

genders <- vvv("gender")

all <- NA
for (conf in vvv_confs(vvv("script", "join.R"))) {
  print(conf$gender) 
}

OUTPUT <- "../data/e"
file.create(OUTPUT, showWarnings=F)