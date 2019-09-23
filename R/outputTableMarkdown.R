#' Converts information about relation tables from two databases in matrices
#' into markdown format
#'
#' @param table_name_list A list of table names
#' @param newer_db_mat A matrix containing information about a newer database
#' @param older_db_mat A matrix containing information about an older database
#' @param new_only A boolean value to specify whether table information from databases are required or not
#' @return A vector containing strings representing information about tables in markdown format
#' @export
outputTableMarkdown <- function(table_name_list, newer_db_mat, older_db_mat, new_only) {
    out <- c()

    for(table in table_name_list) {
        out <- c(out, stringr::str_c("## Newer table: ", table))
        # Get matrix for the table
        m <- newer_db_mat[newer_db_mat[, 1] == table, ]
        out <- c(out, "Column Name | Type")
        out <- c(out, "----------- | ----")
        out <- c(out, stringr::str_c(as.character(m[, 2]), " | ", as.character(m[, 3])))
        if(!new_only) {
            out <- c(out, stringr::str_c("## Older table: ", table))
            # Get matrix for the table
            m <- older_db_mat[older_db_mat[, 1] == table, ]
            out <- c(out, "Column Name | Type")
            out <- c(out, "----------- | ----")
            out <- c(out, stringr::str_c(as.character(m[, 2]), " | ", as.character(m[, 3])))
        }
        # Add horizontal line
        out <- c(out, "<hr>\n")
    }
    return(out)
}