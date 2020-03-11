#' @name browse_repos
#' 
#' @title Browse repositories contained in a list
#' 
#' @description 
#' All links contained in a list with the structure of [.gisrepos] will be
#' opened in the default browser.
#' 
#' @param db A list with the same structure as [.gisrepos].
#' @param idx An index (optional) passed to [subset_db()].
#' 
#' @examples 
#' browse_repos(.gisrepos, 1:2)
#' 
#' @export browse_repos
#' 
browse_repos <- function(db, idx) {
	if(!missing(idx))
		db <- subset_db(db, idx)
	with(db, for(i in 1:nrow(links))
				browseURL(links$url[i]))
}
