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
#' @param output A character value indicating whether the output should be a
#'     html file or a list.
#' @param filename A character value with the name of the ouput html file
#'     (without file extension), used only for `output="html"`.
#' @param date_format A character value indicating the format to be used for
#'     date in html document (passed to [format()]).
#' @param keep_rmd A logical value indicating whether the Rmd file should be
#'     kept or deleted (used only for `output="html"`).
#' 
#' @return 
#' Either a html file (`output="html"`) or a list (`output="list"`) with
#' selected data sets.
#' 
#' @examples 
#' ## Write a html
#' search_repo("temp")
#' ## Get a list
#' temp_repos <- search_repo("temp", output="list")
#' 
#' @export search_repo
#' 
search_repo <- function(topic, db=.gisrepos, output=c("html","list"),
		filename=".temp", date_format="%d-%m-%Y", keep_rmd=FALSE) {
	Sel <- data2text(db)
	Sel <- Sel[grepl(topic, Sel$description, ignore.case=TRUE),"id"]
	if(length(Sel) == 0)
		stop("No matched data sets.")
	db$data_sets <- with(db, data_sets[data_sets$id %in% Sel,])
	output <- pmatch(output[1], c("html","list"))
	if(!output %in% c(1,2))
		stop("Invalid value for argument 'output'.")
	if(output == 1) {
		render_html(filename=filename, db=db,
				title=paste0("Results for *", topic, "*"), author="",
				date_format=date_format, keep_rmd=keep_rmd)
		view_html(paste0(filename, ".html"))
	}
	if(output == 2)
		return(subset_db(db, 1:nrow(db$data_sets)))
}
