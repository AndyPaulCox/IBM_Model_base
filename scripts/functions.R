#Functions for model


######################################
### Events ###
######################################
#Contact events
F_contacted<-function(pop1,contacts1){
  contacted<-list()
  #Get the list of individuals that can transmit - i.e.  the contacting + infected population
  contacting_pop<-pop1$id[pop1$infection_state %in% c("IA","IS")] 
  #Get contacts and work out a contact or not
  #contacting_pop<-pop1$id[sample(1:20000,100) ]  ###just for testing select a small sample¡¡¡¡¡¡¡¡
  if(length(contacting_pop)>0){
    for(i in 1:length(contacting_pop)){
      temp_contact1<-contacts1[fromID==contacting_pop[i]]
      prob<-temp_contact1$c_rate
      contacted[[i]]<-temp_contact1$id[rbinom(length(prob),1,prob)==1]#the id number of the people contacted
      #Might want to modify this contacts with the infectivoty of the contacter
    }}
  contacted
}

F_schools<-function(pop1,sch_contacts1){
  
  pop1
}

#Infection Events
F_infection_events<-function(contacted,pop1){
  contacted1<-unlist(contacted)
  if(length(contacted1)>0){
    pers1<-pop1[id%in%contacted1 & infection_state=="S",]#select the person to decide if infected
    pers2<-pers1$id
    prob<-transmissibility_base*trans_adj_risk_group[pers1$risk_group+1]
    inf1<-rep(0,length(prob))
    if(length(prob)>0)inf1<-rbinom(length(prob),1,prob)
    if(sum(inf1)>0){
      pers2<-pers2[inf1==1]
      pop1$infection_state[pop1$id%in%pers2]<-"I"
      pop1$t_since_infection[pop1$id%in%pers2]<-1
    }
  }
  pop1
}

#Time
F_time_events<-function(pop1){
  #advance age
  pop1$age<-pop1$age+(1/365)
  #Advance time since infection for those infected
  pop1$t_since_infection[pop1$t_since_infection>0]<-pop1$t_since_infection[pop1$t_since_infection>0]+1
  #Advance time since diagnosis for those infected
  pop1$t_since_diag[pop1$t_since_diag>0]<-pop1$t_since_diag[pop1$t_since_diag>0]+1
  pop1
}

#Change infection state
F_infection_stage<-function(pop1){
  #susceptible=S,incubating=I,infectious_asymptomatic=IA, infectious_symptomatic=IS, nonifect_symptomatic=NIS,recovered_immune=RI
  pop1$infection_state[pop1$t_since_infection==(incubation_period+transmissibility_start)]<-"IA"
  pop1$infection_state[pop1$t_since_infection==incubation_period]<-"IS"
  pop1$infection_state[pop1$t_since_infection==(incubation_period+transmissibility_end)]<-"NIS"
  pop1$infection_state[pop1$t_since_infection==symptom_duration]<-"RI"
  pop1$infection_state[pop1$t_since_infection==duration_of_immunity]<-"S"
  pop1$t_since_infection[pop1$t_since_infection==duration_of_immunity]<-0
  
  pop1
}


#Case Fatality
F_case_fatality<-function(pop1){
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==0 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==0 ]),1,fatality_rate[1])
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==1 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==1 ]),1,fatality_rate[2])
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==2 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==2 ]),1,fatality_rate[3])
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==3 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==3 ]),1,fatality_rate[4])
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==4 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==4 ]),1,fatality_rate[5])
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==5 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==5 ]),1,fatality_rate[6])
  pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==6 ]<-rbinom(length(pop1$died_dis[pop1$infection_state %in% c("IS","NIS") & pop1$risk_group==6 ]),1,fatality_rate[7])
  
  pop1
}

#Tidy up - Remove people that have died
F_tidy_up<-function(pop1,died_disease){
  rows1<-which(pop1$died_dis==1)
  
  if(length(rows1)>0){
    died_disease[[length(died_disease)+1]]<-pop1$id[rows1]
    #pop1<-pop1[-rows1,]
    setkey(pop1, died_dis)
    pop1 <- pop1[!1]
  }
  pop1
}

#Seed Function
F_seed<-function(pop1){
  
  for(p in 1:seed_no){
    temp<-sample(pop1$id[pop1$lat==41.38792  &  pop1$long==2.169919],1)#Seed infections in  Barcelona
    pop1$infection_state[pop1$id==temp]<-"I"
    pop1$t_since_infection[pop1$id==temp]<-1
  }
  pop1
}

#Collect Data
F_data_out<-function(tt,pop1,oudat1){
  #susceptible=S,incubating=I,infectious_asymptomatic=IA, infectious_symptomatic=IS, nonifect_symptomatic=NIS,recovered_immune=RI
  #   if(tt==0)prev_I<-
  susc<-length(pop1$infection_state[pop1$infection_state=="S"])
  #   new_diag<-
  incid_inf<-length(pop1$infection_state[pop1$infection_state=="I" & pop1$t_since_infection==1])
  I<-length(pop1$infection_state[pop1$infection_state=="I"])
  IA<-length(pop1$infection_state[pop1$infection_state=="IA"])
  IS<-length(pop1$infection_state[pop1$infection_state=="IS"])
  NIS<-length(pop1$infection_state[pop1$infection_state=="NIS"])
  RI<-length(pop1$infection_state[pop1$infection_state=="RI"])
  dead<-length(pop1$died_dis[pop1$died_dis==1])
  outdat1[[tt]]<-c(tt,susc,incid_inf,I,IA,IS,NIS,RI,dead)
  outdat1
}
