#Zheng Zhou
#MA415-Midterm Project

#Load 9 packages
library(tidyr)
library(dplyr)
library(foreign)
library(magrittr)
library(lubridate)
library(stringr)
library(data.table)
library(ggplot2)
library(zipcode)
library(png)

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
#I am interested in the relations between  (site county) and (total number of serious incident).
#Construct table "new" that consists of two columns: sitecnty , totserious.
new <- data.frame(osha$TOTSERIOUS,osha$SITECNTY,osha$SITECITY,osha$SITEZIP)

new1 <- arrange(new,desc(osha.SITEZIP))
#Filter scc to MA only
scc_MA <- subset(scc_1, grepl("MA",scc_1$STATE))


#visulize 
#Goal：finding the area that reports most serious violation.

zipcode_1 <- data(zipcode)
zipcode_MA <- subset(zipcode, grepl("MA", zipcode$state))

new2 <- data.frame(TOTSERIOUS=new1$osha.TOTSERIOUS,zip = new1$osha.SITEZIP)

new3 <- inner_join(new2,zipcode_MA, by = "zip")


ma <- readPNG("MA.png") 

ggplot(new3, aes(y = latitude, x = longitude)) 
+ geom_point(aes(size = TOTSERIOUS,colour = TOTSERIOUS))
+ annotation_custom(rasterGrob(ma, 
                               width = unit(1,"npc"), 
                               height = unit(1,"npc")), 
                    -Inf, Inf, -Inf, Inf)


#Prepareaccid







