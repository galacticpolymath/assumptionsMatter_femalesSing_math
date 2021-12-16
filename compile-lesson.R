# Script for assembling a Galactic Polymath interdisciplinary lesson plan
# ver 0.1.1

require(remotes)
install_github("galacticpolymath/galacticPubs")
library(galacticPubs)
googledrive::drive_auth() #need to authorize your account first time you use this

editor()
