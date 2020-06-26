old_opt <- options(datadist = "dd")
on.exit(options(old_opt))

data("transplant", package = "survival")
transplant <- transplant[transplant[["event"]] != "censored", , drop = FALSE]

test_that("expectation class", {
  skip_on_cran()
  # strong assignment because the scope of test <https://goo.gl/LJn9rF>
  dd <<- rms::datadist(transplant)

  lrm_mod <- rms::lrm(
    event ~ rms::rcs(age, 3) * (sex + abo) + rms::rcs(year, 3),
    data = transplant,
    model = TRUE,
    x = TRUE, y = TRUE
  )

  expect_is(summary_interact(lrm_mod, age, sex), "data.frame")
  expect_is(
    summary_interact(lrm_mod, age, sex, ref_min = 60, ref_max = 80),
    "data.frame"
  )
  expect_is(
    summary_interact(
      lrm_mod, age, sex, ref_min = 60, ref_max = 80, digits = 5L
    ),
    "data.frame"
  )
  expect_is(summary_interact(lrm_mod, age, abo), "data.frame")
  expect_is(
    summary_interact(lrm_mod, age, abo, level = c("A", "AB")),
    "data.frame"
  )
  expect_is(summary_interact(lrm_mod, age, abo, p = TRUE), "data.frame")
})



test_that("expectation throws error if input not an lrm", {
  skip_on_cran()
  # strong assignment because the scope of test <https://goo.gl/LJn9rF>
  dd <<- rms::datadist(transplant)

  ols_mod <- rms::ols(
    futime ~ rms::rcs(age, 3) * (sex + abo) + rms::rcs(year, 3),
    data = transplant,
    model = TRUE,
    x = TRUE,
    y = TRUE
  )

  expect_usethis_error(
    summary_interact(ols_mod, age, sex),
    "model has to inherits to lrm class"
  )
})



test_that("Without refname in datadist it trows an error", {
  skip_on_cran()
  # strong assignment because the scope of test <https://goo.gl/LJn9rF>
  dd <<- rms::datadist(transplant)

  lrm_mod <- rms::lrm(
    event ~ rms::rcs(age, 3) * (sex + abo) + rms::rcs(year, 3),
    data = transplant,
    model = TRUE,
    x = TRUE, y = TRUE
  )

  expect_usethis_error(summary_interact(lrm_mod, age, sexx), "datadist")
  expect_usethis_error(summary_interact(lrm_mod, agee, sex), "datadist")
})



test_that("Without datadist it trows an error", {
  skip_on_cran()

  options(datadist = NULL)

  lrm_mod <- rms::lrm(
    event ~ rms::rcs(age, 3) * (sex + abo) + rms::rcs(year, 3),
    data = transplant,
    model = TRUE,
    x = TRUE, y = TRUE
  )

  expect_usethis_error(summary_interact(lrm_mod, age, sex), "datadist")
})