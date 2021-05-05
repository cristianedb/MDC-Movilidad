#
# COMPARA DATOS DE MOVILIDAD CON LAS MUERTES POR COVID EN LA CIUDAD DE BS AS
#
# 2021-04-19  version actual:   2021-05-04 
# GRUPO:  
################################################################################

source("check_packages.R")
source("mobility_df.R")
source("covid_df.R")
source("grafica.R")


check_packages()

city = "Buenos Aires"
trans = "walking"

#Obtiene dataframe de movilidad
movilidad<-get_mobility_df(city,trans)

#Obtiene dataframe de COVID death
COVID_19<-get_covid_death_per_day()

#Unir los dos dataframes, se usa la fecha como Key (tienen el mismo nombre)
final<- merge(movilidad, COVID_19)

#grafica
graficar(final)
