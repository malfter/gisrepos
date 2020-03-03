# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

Data <- readLines("data-raw/GIS_Repositories.txt")
Data <- subset(Data, Data != "")
Data <- subset(Data, !grepl("\\vspace{", Data, fixed=TRUE))

# Format table
Data <- data.frame(id=NA, item=3, content=Data, stringsAsFactors=FALSE)
Data$item <- with(Data, {
			item[substring(content, 1, 2) == "**"] <- 1
			item[substring(content, 1, 3) == "htt"] <- 2
			item
		})
Data$id <- with(Data, {
			id <- item == 1
			id <- cumsum(id)
			id
		})

Titles <- subset(Data, item == 1)[,c("id","content")]
Titles$content <- gsub("**", "", Titles$content, fixed=TRUE)
colnames(Titles)[2] <- "name"

Descr <- subset(Data, item == 3)[,c("id","content")]
Descr <- split(Descr$content, Descr$id)
Descr <- unlist(lapply(Descr, function(x) paste0(x, collapse=" ")))

# Delete leading and trailing blanks
Descr <- trimws(Descr, "both")

Titles$description <- Descr

data_sets <- Titles

links <- unique(subset(Data, item == 2)$content)
links <- data.frame(link_id=1:length(links), url=links, stringsAsFactors=FALSE)

any(duplicated(links$url))

data_links <- subset(Data, item == 2)[,c("id","content")]
data_links$link_id <- with(links, link_id[match(data_links$content, url)])
data_links <- data_links[,c("id","link_id")]

gisrepos <- list(data_sets=data_sets, data_links=data_links, links=links)

save(gisrepos, file="data-raw/gisrepos.rda")
