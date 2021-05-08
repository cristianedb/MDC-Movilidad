#
# COMPARA DATOS DE MOVILIDAD CON LAS MUERTES POR COVID EN LA CIUDAD DE BS AS
#
# 2021-04-19  version actual:   2021-05-04 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
################################################################################

source("check_packages.R")
check_packages()

city = "Buenos Aires"
trans = "walking"

#Obtiene dataframe de movilidad
# 'dynamic' lo toma desde la pagina
# 'manual' lo toma desde el archivo en el raiz con nombre "applemobilitytrends.csv"
source("mobility_df.R")
movilidad<-get_mobility_df(city,trans,'dynamic') 

#Obtiene dataframe de COVID death
source("covid_df.R")
COVID_19<-get_covid_death_per_day()

#Unir los dos dataframes, se usa la fecha como Key (tienen el mismo nombre)
final<- merge(movilidad, COVID_19)

# Grafica las muertes vs la movilidad
source("grafica.R")
graficar(final)
# si bien se observa que la movilidad empezó a disminuir cuando los muertos se
# empezaron a elevar esto pudo haber sido porqu la misma gente empezó a cuidarse 
# mas (en general)
# Luego con el DNU ayudó un poco mas a la disminución de la movilidad 
# las muertes siguen creciendo unos días mas


#Se genera una funcion que genere un retraso en la serie
lag_serie <-function(serie,lag){ 
    x1<-serie[lag:length(serie)]
    # Dado a que la funcion vector genera el valor 0 como default, se hace
    # su propia división para que aparezcan valores NAN correspondientes a las 
    # muestras futuras
    
    x2<-vector(mode = "numeric", length = lag-1)/vector(mode = "numeric", length = lag-1)
    return(c(x1,x2))
  }

lag=15
# Se realiza la grafica con un delay de 15 días
final$MUERTES_POR_DIA=lag_serie(final$MUERTES_POR_DIA,15)
graficar(final)

# Se observa que la cantidad de muertes (desfasada 15 días) empieza a disminuir 
# con el DNU
