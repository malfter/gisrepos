#' @name read_template
#' 
#' @title Read the updated template
#' 
#' @description 
#' This function imports the updated entries that are stored in a standard
#' Excel sheet into a data frame in the running R session.
#' 
#' @param file A character vector indicating the path and the name of the
#'     template Excel book.
#' @param main_table A character value indicating the name of the sheet
#'     containing the main table in the Excel book.
#' @param ... Further arguments passed to [read_ods()].
#' 
#' @keywords internal
#' 
read_template <- function(file, main_table="main_table", ...) {
	file <- read_ods(file, main_table, ...)
	## file <- read.xlsx(file, sheetName=main_table, ...)
	## file <- file[,!grepl("NA.", colnames(file), fixed=TRUE)]
	if(!"id" %in% colnames(file))
		file$id <- 1:nrow(file)
	return(file)
}
