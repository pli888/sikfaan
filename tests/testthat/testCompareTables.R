test_that("running compareTables", {
    older <- read.csv(system.file("testdata", "older.csv", package = "sikfaan", mustWork = TRUE), header=TRUE, sep=",")
    newer <- read.csv(system.file("testdata", "newer.csv", package = "sikfaan", mustWork = TRUE), header=TRUE, sep=",")

    x <- compareTables(older, newer)
    # Check 2nd line of output is ## Newer table: NewTable
    expect_equal(x[2], "## Newer table: NewTable")
})
