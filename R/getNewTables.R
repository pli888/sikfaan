#' Returns the names of new tables between two lists of table names from two versions of a database
#'
#' @param newer_db_mat_tab_names A vector containing table names from a newer database
#' @param older_db_mat_tab_names A vector containing table names from an  older database
#' @return A vector containing table names unique to the newer database
#' @export
getNewTables <- function(older_db_mat_tab_names, newer_db_mat_tab_names) {
    tables_new <- c()

    # Identify new tables found in newer database but not in old database
    new_tabs <- newer_db_mat_tab_names[!newer_db_mat_tab_names %in% older_db_mat_tab_names]
    if(length(new_tabs) > 0) {
        # Get table columns for new tables
        for(table in new_tabs) {
            tables_new <- c(tables_new, table)
        }
    }
    return(tables_new)
}