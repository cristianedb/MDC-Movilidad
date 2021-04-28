# COMPARA DATOS DE MOVILIDAD CON LAS MUERTES POR COVID EN 
# LA CIUDAD DE BUENOS AIRES
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

source("movility_df.R")
source("covid_df.R")
source("grafica.R")

country='Argentina'
city = "Buenos Aires"
trans = "walking"

#Obtiene dataframe de movilidad
movilidad<-get_movility_df(country,trans)

#Obtiene dataframe de COVID death
COVID_19<-get_covid_death_per_day()

#Unir los dos dataframes, se usa la fecha como Key (tienen el mismo nombre)
final<- merge(movilidad, COVID_19)

#grafica
graficar(final)
