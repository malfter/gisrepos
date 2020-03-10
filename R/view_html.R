#' @name view_html
#' 
#' @title Display rendered html file
#' 
#' @description 
#' This function displays files rendered by [render()] or [render_html()] in the
#' default browser.
#' 
#' @param filename Character vector showing the name of the file to be
#'     displayed.
#' 
#' @keywords internal
#' 
view_html <- function(filename) browseURL(paste0('file://', file.path(getwd(),
							filename)))
