#' Extracts the column names for tables in a PostgreSQL SQL dump file.
#'
#' @param sqlfilepath A file path to the SQL dump file.
#' @return A matrix containing the names of database tables and their columns.
#' @examples
#' \dontrun{
#' getTableInfo("sikfaan/inst/testdata/older.sql")
#' }
#' @export
getTableInfo <- function(sqlfilepath){
    text <- readLines(sqlfilepath)
    END <- ");"
    status <- 0

    table_names <- c()
    table_columns <- c()
    table_column_types <- c()

    tab_names <- getTableNames(sqlfilepath)

    for(table_name in tab_names) {
        START <- ""
        if(grepl("bootstrap", sqlfilepath)) {
            START <- paste("CREATE TABLE ", table_name, sep="")
        }
        else {
            START <- paste("CREATE TABLE public.", table_name, sep="")
        }
        START <- paste(START, " ", sep="")

        for (line in text) {
            line <- stringr::str_replace_all(line, '\\"', "")
            if(grepl(START, line)) {
                status <- 1
                next
            }
            if(grepl(END, line)) {
                status <- 0
            }
            if(status == 1) {
                tokens <- stringr::str_split(line, stringr::boundary("word"))
                # print(word(line, 5))
                table_names <- c(table_names, table_name)
                table_columns <- c(table_columns, tokens[[1]][1])
                column_type <- stringr::word(line, 6, -1)
                column_type <- stringr::str_replace_all(column_type, ",", "")
                table_column_types <- c(table_column_types, column_type)
            }
        }
    }

    # Create matrix of table names and table columns
    mat <- cbind(table_names, table_columns, table_column_types)
    return(mat)
}