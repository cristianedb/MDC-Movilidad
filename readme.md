# Maestría en ciencia de datos
## Trabajo práctico de R

### Integrantes
* Cristian Veiga
* Cristian De Blasis
* Gabriel Guiño
* Guillermo Millich
* Nicolas Gentile

### Objetivo
Visualizar los datos (públicos) de movilidad provisto por apple con las muertes por COVID-19 en Bs AS

### Archivos involucrados
A fin de ser mas claro en la codificación, se separó la tarea en scripts o archivos .R separados los cuales se encargan de una funcionalidad en especial. Esto no solo mejora el mantenimiento sino que permite que el trabajo en grupo sea más dinámico.

Los archivos involucrados en el proyecto son:

* **main.R**: Como su nombre o indica, es el archivo principal que al ejecutarlo se obtiene el resultado deseado.

* **check_packages.R**: Verifica los paquetes necesarios para que el proyecto funcione correctamente

* **covid_df.R**: Obtiene los datos y genera un dataframe de la estadística de COVID-19 en CABA

* **mobility_data_raw.R**: Se encarga de obtener los datos crudos desde la página de iphone. En este caso como se trara de una url que va cambiando de versión y otras veces cambia otras partes de su url se utilizó un algoritmo que intenta varias "versiones" y en caso de no logar el objetivo hace un Web scrapping dinámico (Rselenium) a fin de otener la url del archivo con los datos públicos.

* **mobility_df.R**: Utiliza los datos anteriores y genera un dataframe limpio y listo para ser utilizado

* **grafica.R**: Se encarga de la parte gráfica

### Documentación
El detalle de estos scripts se encuentan en formato html en la carpeta **documentación.html**