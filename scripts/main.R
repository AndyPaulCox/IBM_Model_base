#Main file
for(tt in 1:timespan1){
  contacted<-F_contacted(pop1,contacts1)
  fie<-pop1<-F_infection_events(contacted,pop1)
  
  fis<-pop1<-F_infection_stage(pop1)
  fcf<-pop1<-F_case_fatality(pop1)
  outdat1<-F_data_out(tt,pop1,outdat1)
  ftu<-pop1<-F_tidy_up(pop1,died_disease)
  fte<-pop1<-F_time_events(pop1)
  plot_inf<-pop1[pop1$infection_state!="S",]
  plot_inf<-plot_inf[,c("lat","long")]
  
  temp2<-unique(plot_inf)
  freq1<-plot_inf %>% group_by_all %>% count
  freq2<-as.data.frame(freq1)
  
  pop2<-pop1[infection_state!="S" & infection_state!="RI" , c("lat","long")]
  
  if(nrow(pop2)>400){
    #png(paste0("input_",tt,".png"), width = 1280, height = 720, res = 108)
    # 
    #  bubbleMap(freq2, coords = c("long","lat"), map=map,max.radius = 1,do.sqrt = FALSE,LEGEND=FALSE,colPalette="red",
    #            zcol='n', key.entries = c(5))
    #  #qmplot(long,lat ,data=freq2, colour = I('red'), size = I(0.75), darken = .3,scale=9)
    
    
    # p + stat_density2d(
    #   aes(x = long, y = lat, fill = ..level.., alpha = 0.25),
    #   size = 0.1, bins = 40, data = pop2,
    #   geom = "polygon"
    # )
    
    #  
    #dev.off()
  }
}
end<-Sys.time()
end-stt

