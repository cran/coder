x <- codify(ex_people, ex_icd10, id = "name", code = "icd10",
            date = "surgery", code_date = "admission", days = c(-365, 0))

test_that("codify", {
  expect_silent(codify(ex_people, ex_icd10, id = "name", code = "icd10",
    date = "surgery", code_date = "admission", days = c(-365, 0)))
  expect_is(x, "data.frame")

  # Codes within one year before (i e comorbidities)
  expect_equal(
    nrow(codify(ex_people[1, ], ex_icd10, id = "name", code = "icd10",
           date = "surgery", code_date = "admission", days = c(-365, 0))),
    8
  )

  # Codes within 30 days after (i e adverse events)
  expect_equal(
    nrow(codify(ex_people[1, ], ex_icd10, id = "name", code = "icd10",
                date = "surgery", code_date = "admission", days = c(0, 30))),
    1
  )

  # all codes
  expect_equal(
    nrow(codify(ex_people[1, ], ex_icd10, id = "name", code = "icd10",
        date = "surgery", code_date = "admission", days = c(-Inf, Inf))),
    8
  )

})

# missing dates
# Take minimal data set of people and mask one date
pe <- coder::ex_people[1:2,]
pe$surgery[1] <- NA

# Mask half of the dates from ICD10
icd <- coder::ex_icd10
icd$admission[1:1500] <- NA


test_that("missing dates", {

  expect_equal(
    codify(ex_people, ex_icd10, id = "name", code = "icd10"),
    codify(ex_people, as.data.frame(ex_icd10), id = "name", code = "icd10")
  )

  # Include all dates except missing
  expect_equal(
    nrow(codify(pe, icd, id = "name", code = "icd10",
                date = "surgery", code_date = "admission",
                days = c(-Inf, Inf))),
    9
  )

  # Include all cases, no mather the date
  expect_warning(
    codify(pe, icd, id = "name", date = "surgery",
           code = "icd10", days = NULL))
  expect_silent(codify(pe, icd, id = "name", code = "icd10"))
  suppressWarnings(
    expect_equal(
      nrow(codify(pe, icd, id = "name", code = "icd10",
                  date = "event", days = NULL)),
      16
    )
  )

  expe <- ex_people
  expe$name <- as.numeric(as.factor(expe$name))
  expect_error(
    codify(expe, ex_icd10, id = "name", date = "event"),
    "name must be `character` in 'data' and 'codedata'!"
  )

  expect_error(
    codify(ex_people, ex_icd10, id = "name", code = "missing"),
    "codedata must have column missing"
  )

  expect_error(
    codify(ex_people, ex_icd10, id = "wrong", date = "event"),
    "No id column 'wrong' in data!"
  )
  ex_people$wrong_class <- as.numeric(as.factor(ex_people$name))
  expect_error(
    codify(ex_people, ex_icd10, id = "wrong_class", date = "event"),
    "No id column 'wrong_class' in codedata!"
  )
  expect_error(
    codify(ex_people, ex_icd10, id = "name", code = "icd10", days = c(-10, 10)),
    "Argument 'date' must be specified if 'days' is not NULL!"
  )
  ex_people$wrong_date <- as.character(ex_people$surgery)
  expect_error(
    codify(ex_people, ex_icd10, id = "name", code = "icd10",
           date = "wrong_date", days = c(-10, 10)),
    "wrong_date is not a `Date` column of 'x'!"
  )

  expect_error(
    codify(ex_people, ex_icd10, id = "name", code = "icd10",
           date = "surgery", days = c(-10, 10)),
    "Argument 'code_date' must be specified if 'days' is not NULL!"
  )

  expect_error(
    codify(ex_people, ex_icd10, id = "name", code = "icd10",
           date = "surgery", code_date = "hej", days = c(-10, 10)),
    "hej' is not a `Date` column in 'codedata'!"
  )

  # alnum
  codes <- ex_icd10
  codes$icd10 <-
    paste0("-", substr(codes$icd10, 1, 3), ".", substr(codes$icd10, 4, 5))
  expect_equivalent(
    codify(ex_people, codes,    id = "name", code = "icd10", alnum = TRUE),
    codify(ex_people, ex_icd10, id = "name", code = "icd10")
  )

  expect_output(print(x), "It has 378 row")
})

