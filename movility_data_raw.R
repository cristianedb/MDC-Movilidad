# OBTIENE DATOS DE MOVILIDAD DESDE LA PAGINA DE IPHONE
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

get_movility_data <- function(reintento=0) {
  out <- tryCatch(
    {
      last_version=20+reintento
      url_base=paste('https://covid19-static.cdn-apple.com/covid19-mobility-data/2106HotfixDev',last_version,'/v3/en-us/applemobilitytrends-', sep = "")

      yesterday<-Sys.Date()-2
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
      if(reintento<10) {
        reintento=reintento+1
        message(paste("VERSION DE IPHONE DESACTUALIZADA ",last_version))
        get_movility_data(reintento)
      }
      else{
        return(NULL)
      }
    }
  )    
  return(out)
}
