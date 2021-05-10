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

# Se observa una reducción desde el principio de Abril donde coincide con los
# siguientes hitos:
# 
# 1/4 al 4/4 Semana Santa (caja roja)
# 8/4: Decreto de reducción de movilidad hasta las 23hs (linea punteada)
# 15/4: DNU de reduccion de movilidad 20hs y clases virtuales, etc (linea punteada)

# Dado a la inrcia del sistema las muertes siguieron aumentando, por tal razon 
# se realizará otra gráfica con las muertes retrasada 15 días.

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

# Para confirmar un quiebre de tendencia se deberá recabar información de los 
# días subsiguientes a fin de poder minimizar erroes de diagnostico. 
#A priori, se visualiza una disminucion signifiativa en la muertes
# por día.



