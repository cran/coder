## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(coder)

## -----------------------------------------------------------------------------
default <- categorize(
    ex_people, codedata = ex_atc, cc = rxriskv, id = "name", code = "atc")
default

## -----------------------------------------------------------------------------
hist2 <- function(x) {
  hist(x$pratt, main = NULL, xlab = "RxRisk V", col = "lightblue")
}
hist2(default)

## -----------------------------------------------------------------------------
codify_args <- 
  list(date = "surgery", code_date = "prescription", days = c(-365, -1))

ct <- 
  categorize(
    ex_people, 
    codedata    = ex_atc, 
    cc          = rxriskv, 
    id          = "name", 
    code        = "atc", 
    codify_args = codify_args
  )
  
hist2(ct)

## -----------------------------------------------------------------------------
hist2(
  categorize(
    ex_people, 
    codedata      = ex_atc, 
    cc            = rxriskv, 
    id            = "name", 
    code          = "atc",
    codify_args   = codify_args,
    cc_args       = list(regex = "caughey")
  )
)

## -----------------------------------------------------------------------------
codify(
  ex_people, 
  ex_atc, 
  id        = "name", 
  code      = "atc",  
  date      = "surgery", 
  code_date = "prescription",
  days      = c(-365, -1)
) %>% 
  classify(rxriskv) %>% 
  index("pratt") %>% 
  table()

## -----------------------------------------------------------------------------
s <- function(x) sample(x, 1e3, replace = TRUE)

ex_atc$code <- 
  paste0(
    s(letters), s(0:9), s(letters), s(c(".", "-", "?")), 
    ex_atc$atc, s(letters), s(0:9)
  )

ex_atc

sum(
  categorize(
    ex_people, 
    codedata = ex_atc, 
    cc       = rxriskv, 
    id       = "name",
    code     = "code"
  )$pratt,
  na.rm      = TRUE
)

## -----------------------------------------------------------------------------
hist2(
  categorize(
    ex_people, 
    codedata = ex_atc, 
    cc       = rxriskv, 
    id       = "name",
    code     = "code",
    cc_args  = list(
      start  = FALSE, 
      stop   = FALSE
    ),
    codify_args = list(
      alnum = TRUE
    )
  )
)

