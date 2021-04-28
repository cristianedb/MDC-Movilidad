# COMPARA DATOS DE MOVILIDAD CON LAS MUERTES POR COVID EN 
# LA CIUDAD DE BUENOS AIRES
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
######################################################

library(ggplot2)
library(patchwork)
library(plotly)

# graficar2<-function(final){
#   coeff <- 1.5
#   g1<-ggplot(final, aes(x=FECHA)) +
#     geom_line( aes(y=MOVILIDAD), size=1,color="blue") +
#     geom_line( aes(y=MUERTES_POR_DIA/coeff), size=1,color="red")+
#     ggtitle("COVID_19 - Movilidad vs muertes diarias") +
#     scale_x_date(name = "",date_breaks = "15 day", date_labels =  "%d %b") +
#     theme(axis.text.x = element_text(angle = 45, hjust = 1,face ='bold')) +
#     scale_y_continuous(
#       # Features of the first axis
#       name = "Movilidad",
#       # Add a second axis and specify its features
#       sec.axis = sec_axis(~.*coeff, name="Muertes por día"),
#       limits=c(0,100)
#     )
#   
#   fig <- ggplotly(g1)
#   
#   fig  
# }

graficar <- function(final){
  ay <- list(
    side = "left",
    title = "Movilidad",
    showgrid = F
  )
  ay2 <- list(
    overlaying = "y",
    side = "right",
    title = "Muertes",
    showgrid = F
  )
  ax <- list(
    tickangle = -45,
    showgrid = F
  )
  fig <- plot_ly()
  fig <- fig %>% add_lines(x =final$FECHA, y = final$MOVILIDAD, name = "Movilidad" )
  fig <- fig %>% add_lines(x =final$FECHA, y = final$MUERTES_POR_DIA, name = "Muertes", yaxis = "y2")
  fig <- fig %>% layout(
    title = "COVID19 | Movilidad vs muertes", 
    yaxis2 = ay2,
    yaxis = ay,
    xaxis = ax,
    legend = list(x = 0, y = 1),
    margin = list(l = 50, r = 50, b = 50, t = 50, pad = 4)
  )
  fig 
}


