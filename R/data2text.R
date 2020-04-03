#' @name data2text
#' 
#' @title Merge descriptive columns (text) in a single string
#' 
#' @description 
#' This function makes descriptive columns suitable for search content by using
#' function [grepl()].
#' 
#' @keywords internal
#' 
data2text <- function(x) {
	x <- data2df(x)
	x$description <- with(x, paste(name, description, url, keywords))
	return(x[,c("id", "description")])
}
