#Zheng Zhou
#MA415-Midterm Project

#Goal: find most dangerous place to work in MA

#Load 12 packages
library(tidyr)
library(dplyr)
library(foreign)
library(magrittr)
library(lubridate)
library(stringr)
library(data.table)
library(ggplot2)
require(zipcode)
require(png)
require(pacman)
require(pixmap)

#Load target data tables
osha <- read.dbf("osha.dbf")
accid <- read.dbf("accid.dbf")
viol <- read.dbf("viol.dbf")

#Load look up tables
scc_1 <- read.dbf("lookups/scc.dbf")

#Check dimensions for each table
dim(osha)
dim(accid)
dim(viol)

#Prepare osha
#I am interested in the relations between  area and total number of serious violation.
#Construct table "new" that consists of four columns: TOTSERIOUS,SITECNTY,SITECITY,SITEZIP.
new <- data.frame(osha$TOTSERIOUS,osha$SITECNTY,osha$SITECITY,osha$SITEZIP)

#arrange the data by zipcode in descending order.
new1 <- arrange(new,desc(osha.SITEZIP))

#Filter scc to MA only
scc_MA <- subset(scc_1, grepl("MA",scc_1$STATE))


#Visulize data table
#Goal：finding the area that reported most serious violation.

zipcode_1 <- data(zipcode)

#Filter zipcode to MA zipcode table only
zipcode_MA <- subset(zipcode, grepl("MA", zipcode$state))

#Construct a new table of (# of Serious Violations) and (zipcode)
new2 <- data.frame(TOTSERIOUS=new1$osha.TOTSERIOUS,zip = new1$osha.SITEZIP)

#Perform inner_join so we can connect latitude&longitude with # of serious violations.
new3 <- inner_join(new2,zipcode_MA, by = "zip")

#Import the image of MA google map, to be added as background.
ma <- readPNG("MA.png") 

#draw the graph on MA google map,
ggplot(new3, aes(y = latitude, x = longitude)) + annotation_raster(ma, -Inf, Inf, -Inf, Inf, interpolate = TRUE)   + geom_point(aes(size = TOTSERIOUS,colour = TOTSERIOUS)) +labs(title = "The Map of Total Numbers of Serious Violations Across MA")









