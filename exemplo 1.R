library(ggplot2)
library(dplyr)

melhor_time_br<-"Flamengo"
campeao_87<-"Flamengo"

graf <- diamonds%>%filter(cut=="Ideal")%>%
  ggplot(aes(price))+
    geom_bar()+
  labs(y=NULL, x= "Preço", title = "Distribuição do Preço dos Diamantes com cortes Ideais",
       caption = "Fonte:")

str(melhor_time_br)
str(graf)

