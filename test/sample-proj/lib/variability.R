library(stringr)
library(rjson)

vvv_vars = new.env(parent=emptyenv())

vvv_set <- function(var, value) {
  assign(var, value, envir=vvv_vars)
}
vvv_set("script", "script_name_placeholder")

vvv_get <- function(var) {
  get(var, envir=vvv_vars)
}

# template is a pattern, such as
#
#   "x-%{letter}-%{number}"
#
# the variable "%{script}" refers to this script name
#
vvv_eval <- function(template) {
  pattern <- '[%][{].*?[}]'
  
  info <- str_locate(template, pattern)
  while (!is.na(info[1])) {
    placeholder <- substring(template, info[1], info[2])
    varname <- substring(template, info[1] + 2, info[2] - 1)
    template <- gsub(placeholder, vvv_get(varname), template, fixed=T)

    info <- str_locate(template, pattern)
  }
  template
}

vvv_variables <- function(script) {
  confs <- fromJSON(file='../Vvvfile')
  confs$scripts[[script]]$variables
}

# Testing code
if (1 == 0) {
  vvv_set("letter", "alpha")
  vvv_set("number", "one")
  stopifnot("x-alpha-one" == vvv("x-%{letter}-%{number}"))
  stopifnot("xyz" == vvv("xyz"))
}
