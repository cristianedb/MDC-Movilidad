# OBTIENE DATOS DE MOVILIDAD DESDE LA PAGINA DE IPHONE
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
######################################################

get_mobility_data <- function(type='dynamic',reintento=0) {
  out <- tryCatch(
    { REINTENTOS_MAX=10
      if(type=='dynamic'){
        # Se toman los datos de la red
        if(reintento<REINTENTOS_MAX){
          # Reintenta varias veces probando una version diferente en el caso 
          # de no encontrarla en los primeros 10 intentos utiliza otro metodo
          last_version=9+reintento
          url_base=paste('https://covid19-static.cdn-apple.com/covid19-mobility-data/2107HotfixDev',last_version,'/v3/en-us/applemobilitytrends-', sep = "")
          yesterday<-Sys.Date()-2 # Este se fija si es el dia anterior
          url_day<-paste(url_base,yesterday,'.csv',sep="")
        }
        else{
          # Debido a que la pagina de Apple tiene contenido dinámico se utilizó
          # Rselenium para poder scrappearla y obtener la url necesaria para 
          # dicho proposito
          message("SE UTILIZARA OTRO METODO PARA OBTENER LA URL ")
          message("*************************************************************")
          message("*IMPORTANTE!!:                                              *")
          message("*              SE UTILIZARA OTRO METODO PARA OBTENER LA URL *")
          message("               SE ABRIRA FIREFOX, POR FAVOR NO LO CIERRE    *")
          message("*************************************************************")
          url_day<-get_url()
        }
      }
      else{
        #se toman los datos del archivo
        url_day='applemobilitytrends.csv'
      }
      


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
      if(reintento<REINTENTOS_MAX) {
        reintento=reintento+1
        message(paste("VERSION DE LA MUESTRA DESACTUALIZADA ",last_version))
        get_mobility_data(reintento)
      }
      else{
        return(NULL)
      }
    }
  )    
  return(out)
}

#########################################################################
# DEBIDO A QUE ESTA FUNCION DEMORA UN TIEMPO PARA ENCONTRAR LA URL PRIMERO
# INTENTA CON VALORES ESTATICOS Y DIFERENTES VERSIONES

get_url <- function(reintento=0) {
  library(RSelenium)
  library(rvest)
  rD <- rsDriver(browser="firefox", port=4546L, verbose=F)
  remDr <- rD[["client"]]
  
  Sys.sleep(5)
  remDr$navigate("https://covid19.apple.com/mobility") 
  Sys.sleep(5)
  html <- remDr$getPageSource()[[1]]
  
  signals <- read_html(html) %>% # parse HTML
    html_nodes("div.download-button-container") %>% 
    html_nodes(xpath=".//a/@href")
  
  href<-toString(signals[0:1])
  url<-substr(href,8,nchar(href)-1)
  remDr$close()
  return(url)
}
