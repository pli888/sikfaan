context("running get table names")

test_that("running getTableNames detects correct number of tables in older.sql", {
    expect_equal(length(getTableNames(system.file("testdata", "older.sql", package = "sikfaan", mustWork = TRUE))), 10)
})

test_that("running getTableNames detects correct names of tables in older.sql", {
    expected_table_names <- c("AuthAssignment", "AuthItem",
        "YiiSession", "user_command",
        "alternative_identifiers", "attribute",
        "author", "author_rel",
        "dataset", "dataset_attributes")

    x <- getTableNames(system.file("testdata", "older.sql", package = "sikfaan", mustWork = TRUE))
    expect_true(identical(x, expected_table_names))
})