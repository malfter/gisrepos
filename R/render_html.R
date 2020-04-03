#' @name render_html
#' 
#' @title Render data set in an html display
#' 
#' @description 
#' Function required to produce an overview in the browser
#' 
#' @param filename Character value indicating the name of the output html file
#'     (without file extension).
#' @param db A list with the structure of object '.gisrepos'.
#' @param title Character value with the title for the document.
#' @param author Character value with the name of the document's author.
#' @param date_format Format of date information (passed to [format()]).
#' @param keep_rmd Logical value indicating whether the produced Rmd file
#'     should be kept in the working directory or deleted.
#' 
#' @keywords internal
#' 
render_html <- function(filename=".temp", db=.gisrepos,
		title="Spatial Repositories", author="Alvarez et al.",
		date_format="%d-%m-%Y", keep_rmd=FALSE) {
	Head <- paste0("---\n", "title: ", title, "\nauthor: ", author, "\n",
			"date: '`r format(Sys.Date(), \"", date_format,"\")`'\n",
			"output: html_document\n", "---\n")
	Body <- list()
	for(i in 1:nrow(db$data_sets)) {
		Body[[i]] <- with(db$data_sets,
				paste0("## ", name[i], "\n\n", description[i], "\n"))
		link <- with(db, fk_links[fk_links$id == data_sets$id[i],
						"link_id"])
		link <- with(db$links, paste0(url[link_id %in% link], collapse="\n\n"))
		Body[[i]] <- paste0(Body[[i]], "\n", link, "\n\n<br/>")
	}
	filename <- paste0(filename, ".Rmd")
	con <- file(filename, "wb")
	writeBin(charToRaw(do.call(paste0, list(c(Head, "<br/>", unlist(Body)),
									collapse="\n\n"))),
			con, endian="little")
	close(con)
	## compile with rmarkdown
	render(filename, encoding="UTF-8")
	if(!keep_rmd) unlink(filename)
}
