library(tidyverse)
library(zoo)
library(drc)
library(plotly)
options(scipen = 999)
### Script Datas ###

#dias
seq(Sys.Date()-30,Sys.Date(), by= "day")
#meses XCT
as.POSIXct(seq(Sys.Date()-365,Sys.Date(), by= "month"))
#semanas XLT
as.POSIXlt(seq(Sys.Date()-120,Sys.Date(), by= "week"))


### Analisando Dados covid ###
#extract
url = 'https://raw.githubusercontent.com/wcota/covid19br/master/cases-brazil-states.csv' 
covidBR = read.csv2(url, encoding='latin1', sep = ',') 
#treatment
covidBR$date <- as.Date(covidBR$date, format = "%Y-%m-%d") 

a<-covidBR%>%filter(state =='PE')
#limpando staging area
rm(covidBR, url)

#preparando dados p analise
a$dia<-seq(1:length(a$date))

pred<-rbind(data.frame(dia=a$dia),
            data.frame(dia=seq(max(a$dia)+1, max(a$dia)+180)))
#modelo 1
mod1<-drm(deaths ~ dia, fct = LL2.5(),
    data = a, robust = 'mean')

plot(mod1, log= "", main = "Log logistic")
#previsão 180 dias no futuro
prev<-data.frame(pred=ceiling(predict(mod1,pred)))
prev$data <- seq.Date(as.Date('2020-03-12'), by = 'day', length.out = length(pred$dia))

prev<-merge(prev, a, by.x ='data', by.y = 'date', all.x = T)

plot_ly(prev) %>% add_trace(x = ~data, y = ~pred, type = 'scatter', mode = 'lines', name = "Novos Casos - Predição") %>% add_trace(x = ~data, y = ~totalCases, name = "Casos - Observados", mode = 'lines') %>% layout(
  title = 'Predição de Novos Casos de COVID 19 em Pernambuco', 
  xaxis = list(title = 'Data', showgrid = FALSE), 
  yaxis = list(title = 'Novos Casos por dia', showgrid = FALSE),
  hovermode = "compare")
                      