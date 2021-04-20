
get_covid_death_df <- function(country) {
  URL <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/"
  url_archivo  <- paste(URL,"time_series_covid19_deaths_global.csv", sep = "")
  COVID_19_h  <- read.csv(url_archivo, sep = ",", header = T)
  
  COVID_19_h <- pivot_longer(COVID_19_h,starts_with('X'),names_to='myday',values_to='val')
  COVID_19_h$myday <- as.Date(as.character(COVID_19_h$myday), format = "X%m.%d.%y")
  
  #Filtra los datos necesarios
  COVID_19_h <- subset(COVID_19_h, Country.Region == country)
  COVID_19_h <-subset(COVID_19_h,select=c(myday,val))
  
  return(COVID_19_h)
}


