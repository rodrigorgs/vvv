source("../lib/variability.R", chdir=T)

# JOIN
# INPUT: ../data/d-%{gender}

genders <- vvv("gender", "123")

all <- NA
for (conf in vvv_confs(vvv("script", "join.R"))) {
  print(conf$gender) 
}

# OUTPUT: ../data/e
