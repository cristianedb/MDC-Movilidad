#
# PROCESA DATAFRAME DE MUERTES EN LA CIUDAD DE BUENOS AIRES
#
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
################################################################################



get_covid_death_per_day <- function() {
  # Se decidió buscar otro link dado a que el utilizado en la practica no 
  # contenia datos de muertes para buenos aires
  
  URL <- "https://cdn.buenosaires.gob.ar/datosabiertos/datasets/salud/reporte-covid/"
  url_archivo  <- paste(URL,"dataset_reporte_covid_sitio_gobierno.csv", sep = "")

  library(readr)
  COVID_19 <- read_csv(url_archivo, col_types = cols(FECHA = col_datetime(format = "%d%b%Y:%H:%M:%S")), 
                       locale = locale(tz="America/Argentina/Buenos_Aires"))
  
  #Se exploran columnas
  #colnames(COVID_19)
  
  #se observa los datos en las columnas de interes
  COVID_19$SUBTIPO_DATO <- as.factor(COVID_19$SUBTIPO_DATO)
  #levels(COVID_19$SUBTIPO_DATO)  # Se la comenta, linea solo exploratorea
  
  # [57] "fallecidos_acumulados"                                      
  # [58] "fallecidos_reportados_del_dia"  
  
  # COL DE INTERES: "ï..FECHA","TIPO_DATO","SUBTIPO_DATO","VALOR"         
  # COL A BORRAR: "FECHA_PROCESO","ID_CARGA","TIPO_REPORTE"
  library("dplyr")
  
  # Se elige el SUBTIPO_DATO="fallecidos_reportados_del_dia"  
  COVID_19<-filter(COVID_19, SUBTIPO_DATO=="fallecidos_reportados_del_dia")
  
  #Se analiza la columna TIPO_DATO
  COVID_19$TIPO_DATO <- as.factor(COVID_19$TIPO_DATO)
  #levels(COVID_19$TIPO_DATO)  # Se la comenta, linea solo exploratorea
  
  # [1] "barrios_vulnerables"                                                             
  # [2] "casos_no_residentes"                                                             
  # [3] "casos_por_grupo_etario"                                                          
  # [4] "casos_residentes"                                                                
  # [5] "ocupacion_de_camas_sistema_publico"                                              
  # [6] "personas_hisopadas"                                                              
  # [7] "plan_detectar_bv"                                                                
  # [8] "plan_detectar_movil"                                                             
  # [9] "plan_detectar_total_barrios_vulnerables_detectar_movil"                          
  # [10] "total_de_camas_sistema_publico"                                                  
  # [11] "tr_en_centros_de_salud_hospitales_cesacs_cemar_e_irep"                           
  # [12] "tr_en_fuerzas_de_seguridad_insituto_de_cadetes_transporte_y_carga_manual_policia"
  # [13] "tr_en_geriatricos"  
  
  # COVID_19 %>% group_by(TIPO_DATO) %>% summarise(VALOR = sum(VALOR)) # Se la comenta, linea solo exploratorea
  
  # TIPO_DATO           VALOR
  # <fct>               <dbl>
  #   1 barrios_vulnerables   229
  # 2 casos_no_residentes  2863
  # 3 casos_residentes     7809
  
  # Los tipos de datos que quedan con valores luego del filtrado de subtipo de 
  # datos es una clasificación por tipo de barrios. Por lo tanto para sacar
  # el total de Buenos Aires se tomará la suma de todos ellos
  
  #Selecciona las columnas a trabajar
  COVID_19 <-select(COVID_19,FECHA,VALOR )
  colnames(COVID_19) <- c("FECHA", "MUERTES_POR_DIA")
  
  
  COVID_19<- COVID_19 %>% group_by(FECHA) %>% summarise(MUERTES_POR_DIA = sum(MUERTES_POR_DIA))
  COVID_19$FECHA <- as.Date(COVID_19$FECHA, format = "%d.%m.%Y")

  return(COVID_19)
}



