#
# PROCESA EL DATAFRAME DE MOVILIDAD OBTENIDO DESDE APPLE
#
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
################################################################################

# Carga la funcion para leer desde Iphone
source("mobility_data_raw.R")
library(tidyr)

get_mobility_df <- function(city,trans_type,url_type) {
  # Obtiene datos desde la pagina de Iphone
  mobility<-get_mobility_data(url_type)
  
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



