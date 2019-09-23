#' Compares the structure of relational schema from two databases held in
#' matrices
#'
#' @param older_db_mat A matrix containing table information from a newer database
#' @param newer_db_mat A matrix containing table information from an older database
#' @return A vector containing strings representing information about tables in markdown format
#' @export
compareTables <- function(older_db_mat, newer_db_mat){
    out <- c()

    tables_identical <- c()
    tables_dif_number_cols <- c()
    tables_dif_col_names <- c()
    tables_dif_col_type <- c()
    tables_new <- c()

    # Get table names from databases
    newer_db_mat_tab_names <- unique(newer_db_mat[ , 1])
    newer_db_mat_tab_names <- as.character(newer_db_mat_tab_names)
    older_db_mat_tab_names <- unique(older_db_mat[ , 1])
    older_db_mat_tab_names <- as.character(older_db_mat_tab_names)

    # Get new tables only found in newer database
    tables_new <- getNewTables(older_db_mat_tab_names, newer_db_mat_tab_names)

    # Look at tables in newer database
    for(theTableName in newer_db_mat_tab_names) {
        # Disregard new tables
        if(theTableName %in% tables_new) {
            next
        }

        # Get columns from table
        newer_table <- newer_db_mat[newer_db_mat[, 1] == theTableName, ]
        older_table <- older_db_mat[older_db_mat[, 1] == theTableName, ]
        newer_table_cols <- newer_table[, 2]
        older_table_cols <- older_table[, 2]

        # For table with same number of columns between databases
        if(length(newer_table_cols) == length(older_table_cols)) {
            # Check if tables contain same column names
            col_names_same_status <- 1
            for(newer_tab_col in newer_table_cols) {
                if(!newer_tab_col %in% older_table_cols) {  # Check column name is not in older table
                    col_names_same_status <- 0
                    break
                }
            }
            # Check col types to see if older and newer tables are identical
            if(col_names_same_status == 1) {
                table_same_column_types <- 1
                for(newer_tab_col in newer_table_cols) {
                    newer_tab_col_type <- newer_table[newer_table[, 2] == newer_tab_col, 3]
                    # print(stringr::str_c("Table col in newer database: ", newer_tab_col, " has type: ", newer_tab_col_type))
                    older_tab_col_type <- older_table[older_table[, 2] == newer_tab_col, 3]
                    # print(stringr::str_c("Table col in older database: ", newer_tab_col, " has type: ", older_tab_col_type))
                    # If column type is different
                    if(!pracma::strcmp(as.character(newer_tab_col_type), as.character(older_tab_col_type))) {
                        # print(paste(newer_tab_col, " contains different column type"))
                        table_same_column_types <- 0  # Table contains different column types
                        tables_dif_col_type <- c(tables_dif_col_type, theTableName)
                        break
                    }
                }
                if(table_same_column_types == 1) {  # Tables are identical
                    tables_identical <- c(tables_identical, theTableName)
                }
            }
            else {  # Tables have different column names
                tables_dif_col_names <- c(tables_dif_col_names, theTableName)
            }
        }
        else {  # Tables have different number of columns
            tables_dif_number_cols <- c(tables_dif_number_cols, theTableName)
        }
    }

    # Generate markdown output
    out <- c(out, "# New tables")
    tab_md <- outputTableMarkdown(tables_new, newer_db_mat, older_db_mat, TRUE)
    out <- c(out, tab_md)

    out <- c(out, "# Tables with different number of columns")
    tab_md <- outputTableMarkdown(tables_dif_number_cols, newer_db_mat, older_db_mat, FALSE)
    out <- c(out, tab_md)

    out <- c(out, "# Tables with different column names")
    tab_md <- outputTableMarkdown(tables_dif_col_names, newer_db_mat, older_db_mat, FALSE)
    out <- c(out, tab_md)

    out <- c(out, "# Tables with different column types")
    tab_md <- outputTableMarkdown(tables_dif_col_type, newer_db_mat, older_db_mat, FALSE)
    out <- c(out, tab_md)

    out <- c(out, "# Unchanged tables")
    out <- c(out, stringr::str_c(" * ", tables_identical))
    out <- c(out, "<hr>\n")
    out <- c(out, "| Item | Number |")
    out <- c(out, "| ---- | ------ |")
    out <- c(out, paste("No. of identical tables | ", length(tables_identical), sep=""))
    out <- c(out, paste("No. of tables with different no. of columns | ", length(tables_dif_number_cols), sep=""))
    out <- c(out, paste("No. of tables with different column names | ", length(tables_dif_col_names), sep=""))
    out <- c(out, paste("No. of tables containing columns with different type | ", length(tables_dif_col_type), sep=""))
    out <- c(out, paste("No. of new tables | ", length(tables_new), sep=""))
    out <- c(out, paste("Total no. of tables in newer database | ", length(tables_identical) + length(tables_dif_number_cols) + length(tables_dif_col_names) + length(tables_dif_col_type) + length(tables_new), sep=""))
    return(out)
}
