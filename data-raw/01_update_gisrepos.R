# TODO:   For updating the .gisrepos object
# 
# Author: Miguel Alvarez
################################################################################

library(gisrepos)

# Formatting to data frame
Data <- read_template("data-raw/gisrepos.ods") # Set next after installing
## Data <- gisrepos:::read_template("data-raw/gisrepos.xlsx", stringsAsFactors=FALSE)

Data <- df2data(Data)
## Data <- gisrepos:::df2data(Data)

.girepos <- Data
save(.gisrepos, file="data/gisrepos.rda")
