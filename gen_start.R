# Startup script 
 
suppressPackageStartupMessages({
  library(myLib)
  library(smoother)
  library(tidyverse)
  library(reshape2)
  library(jsonlite)
  library(HDInterval)
  library(knitr)
  library(kableExtra)
}) 

## Note: 
#  myLib is a private library that can be downloaded from my Github. 
#  it contains mainly plot routines for time series.

if(!exists("REPLICATE")){
  print("Use desired start-up script")
} else if(!REPLICATE){
  print("Getting new data")
  source("Get_the_data.R")
} else {
  print("continu with last data")
  load("./data/cases_df.Rdata")
  load("./data/gem_df.Rdata")
  load("./data/repro_rivm.Rdata")
}
