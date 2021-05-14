# Script for assembling a Galactic Polymath interdisciplinary lesson plan
# ver 0.1.0

require(remotes)
install_github("galacticpolymath/galacticPubs")
library(galacticPubs)
googledrive::drive_auth() #need to authorize your account first time you use this

# Run this script to assemble the assets (e.g. graphs used for presentations,
# videos, etc.) and data structures (JSON files) for publishing the lesson.

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 0: Define Global variables -------------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# The lesson shortTitle, which will be added as a prefix to some file names
shortTitle<-"femalesSing"
fullTitle<-'Learning Chart for "Females singing to be heard"'
targetSubject<-"math" #options= "math","ela","science","social studies"


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 1: Run all subsidiary lesson scripts ---------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# All scripts for making graphs and other visuals for the lesson should be in
# "scripts/"


# Add a comment explaining what each script does and source it
#function for making dot plots from histograms
source("scripts/dotplot.R")
#function for enciphering GGplot label text
source("scripts/enciphR.R")
#code to make dotplot-binned-dotplot-histogram animation
source("scripts/histogram_animation")
#code for making generic plots using penguin data for Part 3 presentations
source("scripts/penguinPlots.R")
#code for making the polymath puzzle and histogram variants; also banner graphics
source("scripts/polymathPuzzle-&-histograms.R")



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 2: Compile alignment data --------------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# compile the alignment matrix into a tidy tibble & output a JSON for Strapi

## Import the completed lesson alignment matrix from the meta subfolder
# Suggestion for the file to import


# Aggregate alignment matrix notes and codes; merge with the alignments master
# document from our standardX package
alignment<-compileStandards()

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 3: Output GP Learning Epaulette --------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Output subject percentage breakdown that will go at the top of the
# GP Sensible Lesson Plan

learningEpaulette(alignment,
                  targetSubj=targetSubject,
                  fileName=paste0(shortTitle,"_LearningEpaulette"))



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 4: Output GP Learning Chart ------------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Output the custom windrose chart that will go in the standards section of
# the GP Sensible Lesson Plan
learningChart(alignment,
              targetSubj=targetSubject,
              caption=fullTitle,
              fileName=paste0(shortTitle,"_LearningChart"))



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 5: Output lesson chunking visuals ------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#deprecated

# part1Chunks<-c(15,10,15,5)
# part2Chunks<-c(10,5,15,10,5)
# part3Chunks<-c(5, 10,10,5,5,10)
# galacticPubs:::timeChunk(45,part1Chunks,prefix="Part1",destFolder="assets/time-chunking-figs")
# galacticPubs:::timeChunk(45,part2Chunks,prefix="Part2",destFolder="assets/time-chunking-figs")
# galacticPubs:::timeChunk(45,part3Chunks,prefix="Part3",destFolder="assets/time-chunking-figs")

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 5: Add/Update Google Drive Share Links for Lesson Artifacts-----------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
updateTeachingMatLinks(shortTitle)#c("quickPrep_feedback","remote","classroom")


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 6: Compile Procedure -------------------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
## PURPOSE: Compile JSON of the procedure from XLSX spreadsheet
##
## DEPENDENT FILES: meta/procedure.xlsx

compileProcedure()




#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 7: Compile teaching material links and info --------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
compileTeachingMat()






#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 8: Compile Acknowledgements JSON -------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Takes acknowledgment entries from "meta/acknowledgments.xlsx" & turns them into a
# structured JSON for Strapi
compileAcknowledgments()



#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 9: Compile Version Info JSON -----------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Takes version info entries from "meta/version_info.xlsx" & turns them into a
# structured JSON for Strapi
compileVersions()


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 10: Combine JSONs ----------------------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
## PURPOSE: aggregate JSONS into 1 file for uploading to Strapi
##
## DEPENDENT FILES:
# -meta/acknowledgments.json
# -meta/procedure.json
# -meta/standards_*.json
# -meta/teachingMaterials.json
# -meta/versions.json

compileJSON()


#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# STEP 11: Any additional actions --------------------------------------------------
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


