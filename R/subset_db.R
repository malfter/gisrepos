#' @name subset_db
#' 
#' @title Produce a subset of repository list
#' 
#' @description 
#' Produces a subset considering all relationships between data frames included
#' in a list structured as in [.gisrepos].
#' 
#' @param db A list structured in the same way as [.gisrepos].
#' @param idx A vector indicating the rows to be selected in the data frame
#'     `data_sets` within 'db'. It may be either an integer, a logical or a
#'     character vector. In the later case, rows in `data_sets` have to be
#'     named.
#' 
#' @return A list including the subset of 'db'.
#' 
#' @examples 
#' first_repos <- subset_db(.gisrepos, 1:5)
#' 
#' @export subset_db
#' 
subset_db <- function(db, idx) {
	db <- with(db, {
				data_sets <- data_sets[idx,]
				data_links <- data_links[data_links$id %in% data_sets$id,]
				links <- links[links$link_id %in% data_links$link_id,]
				list(data_sets=data_sets, data_links=data_links, links=links)
			})
	return(db)
}
