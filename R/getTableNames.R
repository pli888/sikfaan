#' Extract table names from PostgreSQL SQL dump file.
#'
#' @param sqlfilepath A file path to the SQL dump file.
#' @return A vector containing a list of table names.
#' @examples
#' \dontrun{
#' getTableNames("sikfaan/inst/testdata/older.sql")
#' }
#' @export
getTableNames <- function(sqlfilepath){
    con = file(sqlfilepath, "r")
    table_names <- c()

    while (TRUE){
        line <- readLines(con, n = 1)

        if (length(line) == 0){
            break
        }

        # Find CREATE TABLE statements
        if(grepl("CREATE TABLE", line) == TRUE){
            y <- sub("CREATE TABLE\\s", "", line)
            # Remove ' (' ending string
            z <- sub("\\s\\(", "", y)
            # Remove 'public.' characters
            b <- stringr::str_replace_all(z, "public\\.", "")
            # Remove double quote characters
            c <- stringr::str_replace_all(b, '\\"', "")
            table_names <- c(table_names, c)
        }
    }
    close(con)
    return(table_names)
}