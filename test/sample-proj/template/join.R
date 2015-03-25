source("../lib/variability.R", chdir=T)

vvv_set("gender", "male")

vvv_input <- "../data/d-%{gender}"

genders <- vvv_eval("%{gender}")

all <- NA
for (conf in vvv_variables("join.R")) {
  print(conf$gender) 
}

vvv_output <- "../data/e"
file.create(vvv_output, showWarnings=F)
