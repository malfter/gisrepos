#' @name require_now
#' 
#' @title Install packages only if not yet installed
#' 
#' @description 
#' A list of packages will be compared with the installed ones and if missing,
#' installed. These packages will be also loaded in the current session.
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
	if(update) {
		message("Updating packages...")
		update.packages(ask=FALSE)
	}
	new_pkgs <- pkgs[!pkgs %in% installed.packages()[ ,"Package"]]
	old_pkgs <- pkgs[!pkgs %in% new_pkgs]
	# Grammatically correct message
	if(length(old_pkgs) == 1)
		message(paste0("The package '", old_pkgs, "' is already there ",
						"and will not be installed now."))
	if(length(old_pkgs) > 1)
		message(paste0("The packages '",
						paste(old_pkgs[1:(length(old_pkgs) - 1)],
								collapse="', '"), "' and '",
						old_pkgs[length(old_pkgs)], "' are already there ",
						"and will not be installed now."))
	if(length(new_pkgs) > 0) install.packages(new_pkgs, ...)
	# Loading packages into session
	sapply(pkgs, require, character.only=TRUE)
	message("DONE!")
}
