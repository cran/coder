cb <- codebook(elixhauser, "icd10cm")
cb2 <- codebook(elixhauser, "icd9cmd",
         cc_args = list(regex = "icd9cm_enhanced")
)

cbs <- suppressWarnings(codebooks(cb1 = cb, cb2 = cb2))

test_that("codebook", {
  expect_is(cb, "codebook")
  expect_named(cb, c("readme", "summary", "all_codes"))
  expect_named(
    cbs,
    c("README", "cb1.summary", "cb1.all_codes", "cb2.summary", "cb2.all_codes")
  )

  expect_message(
    codebook(elixhauser, "icd10cm", file = tempfile()),
    "codebook saved as"
  )

  expect_message(
    codebooks(cb1 = cb, cb2 = cb2, file = tempfile()),
    "codebooks saved as"
  )

  expect_output(print(cb), "Preview of ")
})

