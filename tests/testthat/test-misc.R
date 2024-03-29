test_that("misc", {
  expect_equal(iris, copybig(iris, FALSE))

  expect_equal(clean_text("prefix", "Hello World!"), "prefix_hello_world_")
  expect_error(
    clean_text(iris, "wrong"),
    "Object iris must be refferred by name"
  )

  expect_equal(decoder_data("ben"), decoder::ben)
  expect_error(decoder_data("wrong_yee!"), "'coding' should be one of")

  expect_output(print_tibble(iris), "The printed data is of class: data.frame.")
  expect_output(
    print_tibble(iris, n = NULL),
    "[^(The printed data is of class: data.frame.)]"
  )
})

