#
# VERIFICA QUE TODOS LOS PAQUETES NECESARIOS SE ENCUENTREN INSTALADOS 
#
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
################################################################################

options(allow_html=TRUE)
# Bibliotecas a importar
check_packages <- function() {
  # Se definen todos los paquetes a utilizar
  packages <- c("base", "datasets", "dplyr","methods","rvest","XML","grDevices","httr",
                       "ggplot2", "graphics" ,
                       "methods", "patchwork", "plotly", "readr","stats","tidyr","utils" )
  
  
  if (all(packages %in% rownames(installed.packages()))) {
    TRUE
  } else{
    cat(
      "Instalar los siguientes packages antes de ejecutar el presente script\n",
      packages[!(packages %in% rownames(installed.packages()))],
      "\n"
    )
  }
}

