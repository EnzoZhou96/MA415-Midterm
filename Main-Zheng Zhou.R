#Zheng Zhou
#MA415-Midterm Project

#Load 10 packages
library(tidyr)
library(dplyr)
library(foreign)
library(magrittr)
library(lubridate)
library(stringr)
library(data.table)
library(ggplot2)
library(scale)
library(zipcode)

#Load target data tables
osha <- read.dbf("osha.dbf")
accid <- read.dbf("accid.dbf")

#Construct table "new" that consists of two columns: sitezip , totserious.
new <- data.frame(osha$SITEZIP,osha$TOTSERIOUS)

#Arrange table by zipcode in decreasing order.
new2 <- arrange(new,desc(osha.SITEZIP))

#Modify the table to filter out zip codes that do not belong to MA or are missing.
new3 <- new2[136:80384,]

#visulize new3
#Goal：finding the area that reports most serious violations









