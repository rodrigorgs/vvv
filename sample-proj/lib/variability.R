library(rjson)

# key can be "script" (replaces by script name)
vvv <- function(key, default_value) {
  value <- Sys.getenv(key, unset = NA)
  if (is.na(value)) {
    value <- default_value
  }
  value
}

vvv_confs <- function(script) {
  confs <- fromJSON(file='../Varconf.json')
  confs[[script]]
}
