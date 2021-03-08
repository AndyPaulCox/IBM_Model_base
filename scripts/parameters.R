#Parameters


######################################
### Disease dynamics parameters ###
######################################
timespan1<-10
p_phen=c(0.1,0.2,0.3,0.4)
p_eth=c(0.1,0.1,0.3,0.4,0.1)
p_workstate=c(0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1,0.1)

transmissibility_base<-0.1
trans_adj_risk_group<-c(0.5,0.8,1,1.1,1.2,1.3,1.4)
fatality_rate<-c(0.01,0.03,0.05,0.08,0.1,0.2,0.3)
transmissibility_start<--3 #With respect to start of symptoms
transmissibility_end<-5 #With respect to start of symptoms
incubation_period<-7
symptom_duration<-14
duration_of_immunity<-365
seed_no<-3

#Contacts per day used in data prep file
comm_cont_rate<-c(1/14,1)#Range low to high
comm_cont_rand<-c(1/2,1)#Range low to high
comm_cont_LD<-c(1/60,1/20)#Range low to high

#Data Collection
died_disease<-list()
######################################
### Intervention parameters ######
#####################################
social_dist<-c(0.5,0.5,0.5)
