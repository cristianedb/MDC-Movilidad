# PROCESA EL CSV OBTENIDO DESDE LA PAGINA DE MOVILIDAD
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

# Carga la funcion para leer desde Iphone
source("movility_data_raw.R")
library(tidyr)

get_movility_df <- function(city,trans_type) {
  # Obtiene datos desde la pagina de Iphone
  mobility<-get_movility_data()
  
  #Le da un tipo a las columnas
  mobility$geo_type              <- as.factor(mobility$geo_type)
  mobility$region                <- as.factor(mobility$region)
  mobility$transportation_type   <- as.factor(mobility$transportation_type)
  
  #Modifica la estructura de la tabla 
  mobility <- pivot_longer(mobility,starts_with('X20'),names_to='FECHA',values_to='MOVILIDAD')
  mobility$FECHA <- as.Date(mobility$FECHA, format = "X%Y.%m.%d")

  #Filtra los datos necesarios
  mobility <- subset(mobility, region == city & transportation_type == trans_type)
  mobility <-subset(mobility,select=c(FECHA,MOVILIDAD))
  
  return(mobility) 
}



