#Outputs
write.csv(pop1,"pop1.csv")


out1<-do.call(rbind.data.frame, outdat1)
colnames(out1)<-c("Day","Susc","Incident_Inf","Incubating","Inf_Asym","Infectious_Sympt","Not_infect_sympt","Recov_Imm","Dead")
plot(out1$Day,out1$Susc,type="l",col="red",ylim=c(0,26500))
lines(out1$Day,out1$Incident_Inf,col="blue")
lines(out1$Day,out1$Incubating,col="purple")
lines(out1$Day,out1$Recov_Imm,col="brown")
lines(out1$Day,out1$Dead,col="green")

plot(out1$Day,out1$Incident_Inf,type="l",col="red",main="Incident Infections",xlab="Day",ylab="Number of Infections")

plot(out1$Day,out1$Dead,type="l",col="green",main="Deaths",xlab="Day",ylab="Number of Deaths")

#############################################################################3
#############################################################################3
#############################################################################3
#############################################################################3

png_files <- sprintf("input_%02d.png", 1:99)
av::av_encode_video(png_files, 'output.mp4', framerate = 2)
utils::browseURL('output.mp4')

#############################################################################3
#############################################################################3
#############################################################################3
#############################################################################3



##Diagnostics
contacted<-F_contacted(pop1,contacts1)
fie<-pop1<-F_infection_events(contacted,pop1)
fte<-pop1<-F_time_events(pop1)
fis<-pop1<-F_infection_stage(pop1)
fcf<-pop1<-F_case_fatality(pop1)
ftu<-pop1<-F_tidy_up(pop1)

tt
nrow(pop1)
length(contacted)
#pop1[pop1$infection_state=="I",]
table(pop1$infection_state)
table(pop1$t_since_infection)
tt<-tt+1

# this sets your google map for this session
# register_google(key = "AIzaSyARjZC1ZjygRbqQYLgsTTppeqw5M7kHscw")

gc <- geocode("catalunya, spain", source = "google")
center <- as.numeric(gc)
ggmap(get_googlemap(center = center, scale = 2), extent = "device",maytype="hybrid")


bubbleMap(freq2, coords = c("long","lat"), map=map,max.radius = 5,do.sqrt = FALSE,LEGEND=FALSE,colPalette=fc(5),
          zcol='n', key.entries = c(100))


get_googlemap("catalunya, spain", zoom = 8) %>% ggmap()



############################################################################
# Library
library(leaflet)

# load example data (Fiji Earthquakes) + keep only 100 first lines
data(freq2)


# Create a color palette with handmade bins.
mybins <- c(10,100,500,1000,5000,15000)
mypalette <- colorBin( palette="YlOrBr", domain=freq2$n, na.color="transparent", bins=mybins)

# Prepare the text for the tooltip:
mytext <- "Number Infected" %>%
  lapply(htmltools::HTML)

# Final Map  41.631898, 1.244970
m <- leaflet(freq2) %>% addTiles()  %>% setView( lat=41.631898, lng=1.244970 , zoom=8) %>%
  addProviderTiles("Esri.WorldImagery") %>%
  addCircleMarkers(~long, ~lat, 
                   fillColor = ~mypalette(n), fillOpacity = 0.9, color="white", radius=3, stroke=FALSE,
                   label = mytext,
                   labelOptions = labelOptions( style = list("font-weight" = "normal", padding = "3px 8px"), textsize = "13px", direction = "auto")
  ) %>%
  addLegend( pal=mypalette, values=~n, opacity=0.95, title = "Number Infected", position = "bottomright" )

m 

# save the widget in a html file if needed.
# library(htmlwidgets)
# saveWidget(m, file=paste0( getwd(), "/HtmlWidget/bubblemapQuakes.html"))
m 

# save the widget in a html file if needed.
# library(htmlwidgets)
# saveWidget(m, file=paste0( getwd(), "/HtmlWidget/bubblemapQuakes.html"))
