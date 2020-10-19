#' @name require_now
#' 
#' @title Install packages only if not yet installed
#' 
#' @description 
#' A list of packages will be compared with the installed
#' This function is a wrapper of [update.packages()] and [install.packages()].
#' 
#' @param pkgs Character vector, the names of the packages to be installed.
#' @param update Logical value indicating whether installed packages should be
#'     updated or not (done by [update.packages()]).
#' @param ... Further arguments passed to [install.packages()].
#' 
#' @author Markus Alfter and Miguel Alvarez.
#' 
#' @export require_now
#' 
require_now <- function(pkgs, update=FALSE, ...) {
	if(update)
		update.packages(ask=FALSE)
	new_pkgs <- pkgs[!pkgs %in% installed.packages()[ ,"Package"]]
	message(paste0("The packages '", paste(pkgs[!pkgs %in% new_pkgs],
							collapse="' '"), "' are already installed."))
	if(length(new_pkgs) > 0) install.packages(new_pkgs, ...)
}
