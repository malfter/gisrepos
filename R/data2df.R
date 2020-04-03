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
data2df <- function(x, sep=";\n") {
	# Format links
	links <- with(x, merge(links, fk_links))
	links <- split(links$url, links$id)
	links <- lapply(links, function(x) paste0(x, collapse=sep))
	links <- data.frame(id=as.integer(names(links)), url=unlist(links),
			stringsAsFactors=FALSE)
	# Format keywords
	kword <- with(x, merge(keywords, fk_keywords))
	kword <- split(kword$kword, kword$id)
	kword <- lapply(kword, function(x) paste0(x, collapse=sep))
	kword <- data.frame(id=as.integer(names(kword)), keywords=unlist(kword),
			stringsAsFactors=FALSE)
	# Assemble output object
	x <- merge(x$data_sets, links, sort=FALSE)
	x <- merge(x, kword, all=TRUE, sort=FALSE)
	return(x)
}

#' @keywords internal
#' 
df2data <- function(x, sep=";\n", na.rm=TRUE) {
	# Extracting links
	data_links <- strsplit(x$url, sep)
	for(i in 1:nrow(x)) {
		data_links[[i]] <- data.frame(id=x$id[i], url=data_links[[i]],
				stringsAsFactors=FALSE)
	}
	data_links <- do.call(rbind, data_links)
	links <- unique(data_links$url)
	links <- data.frame(link_id=1:length(links), url=links,
			stringsAsFactors=FALSE)
	data_links$link_id <- with(links, link_id[match(data_links$url, url)])
	# Extracting keywords
	data_keywords <- strsplit(x$keywords, sep)
	for(i in 1:nrow(x)) {
		data_keywords[[i]] <- data.frame(id=x$id[i], kword=data_keywords[[i]],
				stringsAsFactors=FALSE)
	}
	data_keywords <- do.call(rbind, data_keywords)
	if(na.rm)
		data_keywords <- data_keywords[!is.na(data_keywords$kword),]
	kw <- unique(data_keywords$kword)
	kw <- data.frame(kword_id=1:length(kw), kword=kw,
			stringsAsFactors=FALSE)
	data_keywords$kword_id <- with(kw, kword_id[match(data_keywords$kword,
							kword)])
	return(list(
					data_sets=x[,c("id","name","description")],
					links=links,
					keywords=kw,
					fk_links=data_links[,c("id","link_id")],
					fk_keywords=data_keywords[,c("id","kword_id")]
	))
}
