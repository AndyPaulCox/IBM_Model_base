#run fil;e


#Agent Based Model of COVID 19  created byt Andrew Paul Cox  8th March 2021
#List to add



#################################################
#Clear the workspace
rm(list=ls())
#Clear the console
clc()
#clear all plots
library(here) # here() starts at wherever is the working f=directory when this package is loaded

#dev.off()

source(here("scripts/libraries.R"))
start_time <- Sys.time()
source(here("scripts/functions.R"))
#source(here("scripts/getprep_data.R"))
source(here("scripts/parameters.R"))
source(here("scripts/init_vars.R"))

if(fitting==FALSE){
  source(here("scripts/main.R"))
  source(here("scripts/outputs.R"))
}

Sys.time() - start_time

if(fitting==TRUE)source(here("scripts/optim_SA.R"))





