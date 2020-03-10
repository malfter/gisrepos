#' @name search_repo
#' 
#' @title Search GIS repositories
#' 
#' @description 
#' This function retrieves a display of data sets matching a 'topic' by using
#' [grepl()] with option `ignore.case=FALSE`.
#' 
#' @param topic A character value to be matched in the content of the database.
#' @param db Database used for search (by default pre-installed '.gisrepos').
#' @param filename A character value with the name of the ouput html file
#'     (without file extension).
#' @param ... Further arguments.
#' 
#' @examples 
#' search_repo("temp")
#' 
#' @export search_repo
#' 
search_repo <- function(topic, db=.gisrepos, filename=".temp", ...) {
	Sel <- data2text(db)
	Sel <- Sel[grepl(topic, Sel$description, ignore.case=TRUE),"id"]
	db$data_sets <- with(db, data_sets[data_sets$id %in% Sel,])
	render_html(filename=filename, db=db,
			title=paste0("Results for *", topic, "*"), author="", ...)
	view_html(paste0(filename, ".html"))
}
