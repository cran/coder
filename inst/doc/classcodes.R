## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(coder)

## -----------------------------------------------------------------------------
categorize(ex_people, codedata = ex_icd10, cc = charlson, id = "name", code = "icd10")

## -----------------------------------------------------------------------------
all_classcodes()

## -----------------------------------------------------------------------------
charlson

## -----------------------------------------------------------------------------
print(elixhauser, n = 0) # preview 0 rows but present the attributes

## -----------------------------------------------------------------------------
pat <- tibble::tibble(id = "Alice")
diags <- c("C01", "C801", "E1010", "E1021")
decoder::decode(diags, decoder::icd10cm)

## -----------------------------------------------------------------------------
icd10 <- tibble::tibble(id = "Alice", icd10 = diags)
x <- categorize(pat, codedata = icd10, cc = elixhauser, 
                id = "id", code = "icd10", index = "sum_all", check.names = FALSE)
t(x)

## -----------------------------------------------------------------------------

nomesco <- 
  tibble::tibble(
    id      = "Alice",
    kva     = c("AA01", "NFC01"),
    post_op = c(TRUE, FALSE)
  )

## -----------------------------------------------------------------------------
set_classcodes(hip_ae, regex = "kva")


## -----------------------------------------------------------------------------
categorize(pat, codedata = nomesco, cc = hip_ae, id = "id", code = "kva",
           cc_args = list(regex = "kva"))


## -----------------------------------------------------------------------------
charlson_icd8 <- 
  set_classcodes(
    "charlson",
    regex      = "icd8_brusselaers", # Version based on ICD-8
    start      = FALSE, # Codes do not have to occur in the beginning of a vector
    stop       = TRUE,  # Code vector must end with the specified codes
    tech_names = TRUE   # Use long but unique and descriptive variable names
  )

## -----------------------------------------------------------------------------
charlson_icd8

## -----------------------------------------------------------------------------
classify(410, charlson_icd8)

## -----------------------------------------------------------------------------
classify(
  410,
  "charlson",
  cc_args = list(
    regex      = "icd8_brusselaers", 
    start      = FALSE, 
    stop       = TRUE,
    tech_names = TRUE
  )
)

