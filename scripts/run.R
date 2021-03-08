#run


#Model of COVID 19  created byt Andrew Paul Cox  30th October 2019
#model with staged infectivity  Model no age 

#List to add
#Differential Susceptibility by age
#Age 
#Age contact matrix
#NPIs
#Differential transmisibility by stage (Have this to some extent in the BEta's)

#In this version I removed the hospitalization and critical care and the need as  part of the flow of the model
# As does not make sense to have these as additional and separate waiting times / durations they should be modelled statically frpom model outputs
#Adding age specific contact rates
#In V4 adding age
#V6 moving away from using the deSolve package as too cumbersome for all but simple models
#V7 adding age dependent contact matrix
#V8 adding NPIs (Historical patterns)


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
source(here("scripts/getprep_data.R"))
source(here("scripts/parameters.R"))
source(here("scripts/init_vars.R"))

if(fitting==FALSE){
  source(here("scripts/main.R"))
  source(here("scripts/outputs.R"))
}

Sys.time() - start_time

if(fitting==TRUE)source(here("scripts/optim_SA.R"))





