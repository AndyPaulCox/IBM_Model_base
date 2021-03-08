#Initialize


pth1<-"data/CataloniaMicroDataLatLon.csv"
catpop1<-fread(file =pth1)

pth2<-"data/contactList1.csv"
contacts1<-fread(file =pth2)


######################################
### Set Up Population              ###
######################################
N<-nrow(catpop1)
id<-1:N
pop1<-data.table(
  ID=c("id","home_id","geoloc","family_size","Child_inf","gender","age","care_hrisk_groupHrsPW",
       "recv_home_care","GP_visitsPY","specialist_visitsPY","hosp_admPY","t_since_diag","t_since_infection","symptoms","infection_state",
       "t_to_death","died_dis","risk_group","isolation_state","work_state","pp_equip_use","wash_hands","lat","long"),
  id=id,
  home_id=catpop1$ID_VIV,
  geoloc=catpop1$CA,
  family_size=catpop1$fam_size,
  child_inf=rep(0,N),
  gender=catpop1$SEXO,
  age=catpop1$EDAD,
  care_hrisk_groupHrsPW=catpop1$caringOthers_hoursPW,
  recv_home_care=catpop1$home_care,
  GP_visitsPY=catpop1$GP_visitsPY,
  specialist_visitsPY=catpop1$specialist_visitsPY,
  hosp_admPY=catpop1$hosp_admPY,
  t_since_diag=rep(0,N),
  t_since_infection=rep(0,N),
  symptoms=rep(0,N),
  infection_state=rep("S",N),#susceptible, exposed, infectious, recovered
  t_to_death=rep(0,N),
  died_dis=rep(0,N),
  risk_group=catpop1$covid_risk,
  isolation_state=rep(0,N), #self_isolating, lockdown, not_isolating
  work_state= sample(1:10,N,p_workstate,replace=T),#Healthcare worker, social care worker, essential industry, only_premise_worker, WFH, not_WFH, not_working,retired, school, university
  pp_equip_use=rep(0,N),
  wash_hands=rep(0,N),
  lat=catpop1$Lat,
  long=catpop1$long)

#Tidy up workspace
catpop2<-catpop1[,.(Lat,long)]
rm("catpop1")


temp2<-unique(catpop2)
freq1<-catpop2 %>% group_by_all %>% count


map <- GetMap(center=c(lat=41.543564,lon=1.592928), zoom=8,
              size=c(600,500),destfile = file.path(tempdir(),"meuse.png"),
              maptype="mobile", SCALE = 1)


p <- ggmap(get_googlemap(center = c(lon =1.592928, lat = 41.543564),
                         zoom = 8, scale = 2,
                         maptype ='terrain',
                         color = 'color'))

fc <- colorRampPalette(c("red", "darkred"))

outdat1<-list()#For collecting data
pop1<-F_seed(pop1)

stt<-Sys.time()



