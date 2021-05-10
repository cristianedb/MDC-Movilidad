#
# REALIZA LAS GRAFICAS ENTRE LAS MUERTES Y LA MOVILIDAD
#
# 2021-04-19  version actual:   2021-04-19 
# GRUPO:  
#       Cristian Veiga
#       Cristian De Blasis
#       Gabriel Guiño
#       Guillermo Millich
#       Nicolas Gentile
################################################################################

library(ggplot2)
library(patchwork)
library(plotly)

graficar <- function(final){
  
  MEDIDAS_PREV=as.Date('2021-04-08')
  DNU=as.Date('2021-04-15')
  SEMANA_SANTA_INICIO=as.Date('2021-04-01')
  SEMANA_SANTA_FIN=as.Date('2021-04-04')
  
  xbox <- list(
    type = "rect",
    fillcolor = "red",
    line = list(color = "red"),
    opacity = 0.5,
    x0 = SEMANA_SANTA_INICIO,
    x1 = SEMANA_SANTA_FIN,
    xref = "x",
    y0 = 0,
    y1 = 1, 
    yref = "paper"
    )
  vline <- list(
    type = "line", 
    y0 = 0, 
    y1 = 1, 
    yref = "paper",
    x0 = DNU, 
    x1 = DNU,
    name='DNU',
    line = list(color = "black",dash='dash')
  )
  vline2 <- list(
    type = "line", 
    y0 = 0, 
    y1 = 1, 
    yref = "paper",
    x0 = MEDIDAS_PREV, 
    x1 = MEDIDAS_PREV, 
    name='MEDIDAS',
    line = list(color = "black",dash='dash')
  )
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
    margin = list(l = 50, r = 50, b = 50, t = 50, pad = 4),
    shapes = list(vline,vline2,xbox)
  )
  fig 
}


