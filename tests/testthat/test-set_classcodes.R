y <- x <-
  codify(ex_people, ex_icd10, id = "name", date = "surgery", code = "icd10",
         code_date = "admission", days = c(-365, 0))

x <- suppressWarnings(classify(x, "elixhauser"))
y <- suppressWarnings(classify(y, elixhauser))

test_that("set_classcodes", {
  expect_error(set_classcodes("hejsan"))
  expect_equal(set_classcodes(NULL, x), set_classcodes(elixhauser))
  expect_equal(set_classcodes(NULL, y), set_classcodes(elixhauser))
  expect_length(set_classcodes("elixhauser"), 9)
  expect_message(
    set_classcodes("elixhauser"), "Classification based on: icd10")
  expect_error(
    set_classcodes(elixhauser, tech_names = TRUE),
    "must be refferred by name if"
  )
  expect_equal(
    names(set_classcodes("elixhauser", tech_names = TRUE))[2],
    "icd10"
  )
  expect_error(
    set_classcodes(elixhauser, regex = "wrong"),
    "Column with regular expression not found!")

  expect_equal(
    set_classcodes("elixhauser", start = TRUE, stop = FALSE)$icd10[1],
    "^(I(099|1(10|3[02])|255|4(2[05-9]|3)|50)|P290)"
  )
  expect_equal(
    set_classcodes("elixhauser", start = TRUE, stop = TRUE)$icd10[1],
    "^(I(099|1(10|3[02])|255|4(2[05-9]|3)|50)|P290)$"
  )
  expect_equal(
    set_classcodes("elixhauser", start = FALSE, stop = FALSE)$icd10[1],
    "I(099|1(10|3[02])|255|4(2[05-9]|3)|50)|P290"
  )
  expect_equal(
    set_classcodes("elixhauser", start = FALSE, stop = TRUE)$icd10[1],
    "(I(099|1(10|3[02])|255|4(2[05-9]|3)|50)|P290)$"
  )

  ch <- as.data.frame(charlson)
  expect_error(set_classcodes(ch), "cc is not a classcodes object")

  expect_error(
    set_classcodes(
      set_classcodes("charlson", tech_names = TRUE),
      tech_names = FALSE
    ),
    "classcodes object has technical names. Either re-specify"
  )
})

