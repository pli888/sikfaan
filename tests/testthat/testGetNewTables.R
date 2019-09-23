test_that("running getNewTableNames detects a single new table called NewTable in newer.csv", {
    # Setup test fixtures
    older <- read.csv(file=system.file("testdata", "older.csv", package = "sikfaan", mustWork = TRUE), header=TRUE, sep=",")
    newer <- read.csv(file=system.file("testdata", "newer.csv", package = "sikfaan", mustWork = TRUE), header=TRUE, sep=",")
    newer_db_mat_tab_names <- unique(newer[ , 1])
    newer_db_mat_tab_names <- as.character(newer_db_mat_tab_names)
    older_db_mat_tab_names <- unique(older[ , 1])
    older_db_mat_tab_names <- as.character(older_db_mat_tab_names)

    # Test function
    x <- getNewTables(older_db_mat_tab_names, newer_db_mat_tab_names)
    expect_true(identical(x[1], "NewTable"))
    expect_equal(length(x), 1)
})
