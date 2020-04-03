# TODO:   Example for search files
# 
# Author: Miguel Alvarez
################################################################################

library(devtools)
install_github("kamapu/gisrepos")

library(gisrepos)
search_repo("temp")

Temp <- search_repo("temp", output="list")
browse_repos(Temp)
