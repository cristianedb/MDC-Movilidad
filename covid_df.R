# COMPARA DATOS DE MOVILIDAD CON LAS MUERTES POR COVID EN 
# LA CIUDAD DE BUENOS AIRES
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

get_covid_death_per_day <- function() {
  URL <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/reporte-covid/"
  url_archivo  <- paste(URL,"dataset_reporte_covid_sitio_gobierno.csv", sep = "")

  library(readr)
  COVID_19 <- read_csv(url_archivo, col_types = cols(FECHA = col_datetime(format = "%d%b%Y:%H:%M:%S")), 
                       locale = locale(tz="America/Argentina/Buenos_Aires"))
  
  #Se exploran columnas
  #colnames(COVID_19)

  #se observa los datos en las columnas de interes
  # levels(COVID_19$SUBTIPO_DATO)}
  # [57] "fallecidos_acumulados"                                      
  # [58] "fallecidos_reportados_del_dia"  
  
  # COL DE INTERES: "ï..FECHA","TIPO_DATO","SUBTIPO_DATO","VALOR"         
  # COL A BORRAR: "FECHA_PROCESO","ID_CARGA","TIPO_REPORTE"
  library("dplyr")
  
  COVID_19<-filter(COVID_19, SUBTIPO_DATO=="fallecidos_reportados_del_dia")
  levels(COVID_19$TIPO_DATO)
  
  #Selecciona las columnas a trabajar
  COVID_19 <-select(COVID_19,FECHA,VALOR )
  colnames(COVID_19) <- c("FECHA", "MUERTES_POR_DIA")
  COVID_19<- COVID_19 %>% group_by(FECHA) %>% summarise(MUERTES_POR_DIA = sum(MUERTES_POR_DIA))
  COVID_19$FECHA <- as.Date(COVID_19$FECHA, format = "%d.%m.%Y")

  return(COVID_19)
}



