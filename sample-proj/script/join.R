source("../lib/variability.R", chdir=T)

# JOIN
# INPUT: ../data/d-male
# INPUT: ../data/d-female

genders <- c("male", "female")

all <- NA
for (conf in vvv_confs("\"join.R\"")) {
  print(conf$gender) 
}

# OUTPUT: ../data/e
