# OBTIENE DATOS DE MOVILIDAD DESDE LA PAGINA DE IPHONE
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

get_movility_data <- function(reintento=0) {
  out <- tryCatch(
    {
      url_base='https://covid19-static.cdn-apple.com/covid19-mobility-data/2106HotfixDev13/v3/en-us/applemobilitytrends-'
      
      yesterday<-Sys.Date()-1-reintento
      url_day<-paste(url_base,yesterday,'.csv',sep="")
      message(url_day)
      read.csv(url_day, sep = ",", header = T)
    },
    error=function(cond) {
      message("Error")
      message(cond)
      return(NA)
    },
    warning=function(cond) {
      message("Warning")
      message(cond)
      if(reintento==0) {
        message("Se produjo un error se probará con un día anterior")
        get_movility_data(1)
      }
      else{
        return(NULL)
      }
    }
  )    
  return(out)
}