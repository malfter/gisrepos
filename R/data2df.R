#' @name data2df
#' 
#' @title Convert data set list into data.frame
#' 
#' @description 
#' This function creates a data.frame with the content of a list. Relations
#' associated to the main table will be pasted and separated by semicolons (e.g.
#' links or keywords).
#' 
#' There is also a counter-function `df2data()`.
#' 
#' @param x A list with the structure of object `.gisrepos`.
#' 
#' @keywords internal
#' 
data2df <- function(x) {
	links <- with(x, merge(data_links, links))
	links <- split(links$url, links$id)
	links <- lapply(links, function(x) paste0(x, collapse=";"))
	links <- data.frame(id=as.integer(names(links)), url=unlist(links),
			stringsAsFactors=FALSE)
	x <- merge(x$data_sets, links)
	return(x)
}

#' @keywords internal
#' 
df2data <- function(x) {
	data_links <- strsplit(x$url, ";")
	for(i in 1:nrow(x)) {
		data_links[[i]] <- data.frame(id=x$id[i], url=data_links[[i]],
				stringsAsFactors=FALSE)
	}
	data_links <- do.call(rbind, data_links)
	links <- unique(data_links$url)
	links <- data.frame(link_id=1:length(links), url=links,
			stringsAsFactors=FALSE)
	data_links$link_id <- with(links, link_id[match(data_links$url, url)])
	return(list(
					data_sets=x[,c("id","name","description")],
					data_links=data_links[,c("id","link_id")],
					links=links))
}
