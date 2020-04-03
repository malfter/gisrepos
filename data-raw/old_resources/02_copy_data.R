# TODO:   Data to be imported will be copied from data-raw
# 
# Author: Miguel Alvarez
################################################################################

load("data-raw/gisrepos.rda")
.gisrepos <- gisrepos
save(.gisrepos, file="data/gisrepos.rda")
