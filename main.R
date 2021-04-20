# COMPARA DATOS DE MOVILIDAD CON LAS MUERTES POR COVID EN 
# LA CIUDAD DE BUENOS AIRES
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

source("movility_df.R")

city = "Buenos Aires"
trans = "walking"

#Obtiene dataframe de movilidad
movilidad<-get_movility_df(city,trans)