# TODO:   Add comment
# 
# Author: Miguel Alvarez
################################################################################

library(ODB)

load("data-raw/gisrepos.rda")

# Creating database
odb.create("data-raw/gisrepos.odb")
conn <- odb.open("data-raw/gisrepos.odb")

# 1: data_sets -----------------------------------------------------------------
nchar_name <- with(gisrepos$data_sets, max(nchar(name)))
nchar_description <- with(gisrepos$data_sets, max(nchar(description)))

Query <- paste0('CREATE TABLE "data_sets" (\n',
		'"id" INT PRIMARY KEY,\n',
		'"name" VARCHAR(', nchar_name,'),\n',
		'"description" VARCHAR(', nchar_description, ')\n',
		')\n')
odb.write(conn, Query)

odb.comments(conn, "data_sets", "id") <- "Identifier for repository."
odb.comments(conn, "data_sets", "name") <- "Name of repository."
odb.comments(conn, "data_sets", "description") <- paste("Detailed description",
		"of repository.")

odb.insert(conn, '"data_sets"', gisrepos$data_sets)

# 2: links ---------------------------------------------------------------------
nchar_url <- with(gisrepos$links, max(nchar(url)))

Query <- paste0('CREATE TABLE "links" (\n',
		'"link_id" INT PRIMARY KEY,\n',
		'"url" VARCHAR(', nchar_url,')\n',
		')\n')
odb.write(conn, Query)

odb.comments(conn, "links", "link_id") <- "Identifier for url."
odb.comments(conn, "links", "url") <- "Uniform resource locator."

odb.insert(conn, '"links"', gisrepos$links)

# 3: data_links ---------------------------------------------------------------------
Query <- paste0('CREATE TABLE "data_links" (\n',
		'"id" INT,\n',
		'"link_id" INT,\n',
		'FOREIGN KEY ("id") REFERENCES "data_sets" ("id") ',
		'ON DELETE CASCADE,\n',
		'FOREIGN KEY ("link_id") REFERENCES "links" ("link_id") ',
		'ON DELETE CASCADE\n',
		')\n')
odb.write(conn, Query)

odb.comments(conn, "data_links", "id") <- "Identifier for repository."
odb.comments(conn, "data_links", "link_id") <- "Identifier for url."

odb.insert(conn, '"data_links"', gisrepos$data_links)

odb.close(conn)
