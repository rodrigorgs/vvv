library(rjson)

# template is a pattern, such as
#
#   "x-%{letter}-%{number}"
#
# the variable "%{script}" refers to this script name
#
vvv <- function(template, ...) {
  template <- gsub('[%][{].*?[}]', '%s', template)
  value <- sprintf(template, ...)
  value
}

vvv_confs <- function(script) {
  confs <- fromJSON(file='../Varconf.json')
  confs[[script]]
}

stopifnot("x-alpha-one" == vvv("x-%{letter}-%{number}", "alpha", "one"))
stopifnot("xyz" == vvv("xyz"))
