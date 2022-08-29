## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(coder)

## ---- eval = FALSE------------------------------------------------------------
#  visualize(charlson)

## ---- eval = FALSE------------------------------------------------------------
#  visualize(charlson, "myocardial infarction", regex    = "icd9cm_deyo")

## ---- echo = FALSE------------------------------------------------------------
knitr::include_graphics("regexp_charlson_ci_icd9.png")


## ---- eval = FALSE------------------------------------------------------------
#  visualize(charlson, "myocardial infarction", regex = "icd10")

## ---- echo = FALSE------------------------------------------------------------
knitr::include_graphics("regexp_charlson_ci_icd10.png")


## -----------------------------------------------------------------------------
head(decoder::icd10cm)


## -----------------------------------------------------------------------------
s <- summary(charlson, coding = "icd10cm")
s

## -----------------------------------------------------------------------------
summary(charlson, coding = "icd10se")

## -----------------------------------------------------------------------------
summary(
  charlson, coding = "icd9cmd",
  cc_args = list(regex = "icd9cm_deyo")
)

## -----------------------------------------------------------------------------

cm <- codebook(charlson, "icd10cm")$all_codes
cm[cm$group == "AIDS/HIV", ]

se <- codebook(charlson, "icd10se")$all_codes
se[se$group == "AIDS/HIV", ]


