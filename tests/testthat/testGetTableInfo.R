context("running get table info")

test_that("running getTableInfo detects table names, column names and column types in older.sql", {
    x <- getTableInfo(system.file("testdata", "older.sql", package = "sikfaan", mustWork = TRUE))
    expect_match(x[1, 1], "AuthAssignment")
    expect_match(x[1, 2], "itemname")
    expect_match(x[1, 3], "character varying\\(64\\) NOT NULL")

})

test_that("running getTableInfo detects all tables in older.sql", {
    x <- getTableInfo(system.file("testdata", "older.sql", package = "sikfaan", mustWork = TRUE))
    expect_equal(length(unique(x[,1])), 10)
})