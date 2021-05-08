# OBTIENE DATOS DE MOVILIDAD DESDE LA PAGINA DE IPHONE
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
################################################################################

get_mobility_data <- function(type='dynamic',reintento=0) {
  # Esta funcion tiene la posibilidad de ejecutarla de manera manual o dinamica
  # Es decir, dinamica significa que accede a la url  y manual que directamente
  # utiliza el archivo ya bajado en la carpeta raiz
  
  # Consideraciones de la opción dinámica
  #
  # El link va cambiando distintos lugares
  #
  # https://covid19-static.cdn-apple.com/covid19-mobility-data/2107 <- aca cambia poco
  # HotfixDev14 <- acá cambia casi todos los dias
  # /v3/en-us/applemobilitytrends-2021-05-06.csv <- acá cambia todos los dias 
  #                                                 pero se puede sacar con la fecha
  #
  # Para resolver esto de manera automatica el nombre del archivo se obtiene
  # con los valores de la fecha y el numero al que sigue HotfixDev se obtiene 
  # reintentado varias veces.
  # Si luego de varios reintentos (en este caso 20) no se encuentra el link se 
  # procede a realizar un scraping dinamico de la pagina
  
  out <- tryCatch(
    { 
      # Maxima cantidad de reintentos de versiones que tomará antes de pasar a un websraping
      REINTENTOS_MAX=20
    
      if(type=='dynamic'){
        # Se toman los datos de la red
        if(reintento<REINTENTOS_MAX){
          # Reintenta varias veces probando una version diferente en el caso 
          # de no encontrarla en los primeros 10 intentos utiliza otro metodo
          last_version=14+reintento
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
      if(reintento<REINTENTOS_MAX) {
        reintento=reintento+1
        message(paste("VERSION DE LA MUESTRA DESACTUALIZADA ",last_version+1))
        get_mobility_data('dynamic',reintento)
      }
      else{
        return(NULL)
      }
    }
  )    
  return(out)
}

################################################################################
# Esta función genera un webscraping de la pagina para encontrar el link. Debido
# a que la pagina de apple tiene un renderizado dinamico, es decir el html camia
# cuando se carga la pagina, se utiliza Selenium para R

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
