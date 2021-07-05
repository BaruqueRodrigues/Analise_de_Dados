library(tidyverse)
library(data.table)
library(readxl)
library(lubridate)
#extract data
a<-fread("https://dados.seplag.pe.gov.br/apps/basegeral.csv")
b <- read_excel("tabela6579.xlsx")
###Wrang the data
#removendo linhas que não tem valor analitico
b<-b%>%slice(c(-1,-2,-3,-4))
#criando um index
b$index<-str_detect(b$`Tabela 6579 - População residente estimada`, "(PE)")
#filtrando no Index
b<-b%>%filter(index==TRUE)
#renomeando a base
names(b)<- c("municipio", "população", "index")
#tirando o index
b<-b[,-3]
#limpando pra o fuzzy
b$municipio<-str_remove(b$municipio, ' .(PE.)')
#jogando pra maiscula
b$municipio<-toupper(b$municipio)
#transformando pop em numerio
b$população<-as.numeric(b$população)
#transformando em dt (meu pc sofre)
b<-as.data.table(b)
#criandoa semana epidemiologica
a$semana<-format(floor_date(a$dt_notificacao, "week"), "%Y-W%W")
#fazer o merge
a1<-fuzzyjoin::stringdist_join(a, b, mode='left', by ="municipio")

#calculo de incidência e letalidade por 100k a cada semana 
t<-a1%>%filter(classe== "CONFIRMADO")%>%
  group_by(municipio.x, semana, população)%>%count(classe)%>%arrange(semana)%>%
  mutate("n/100k" = n/população*100000)

#incidência
t%>%group_by(municipio.x,semana)%>%summarise("incidencia"=sum(n),
                                             "incidência por 100k"=sum(`n/100k`))%>%arrange(municipio.x,semana)
t2<-a1%>%group_by(municipio.x, semana,população)%>%count(dt_obito)%>%na.omit()%>%
  mutate("n/100k"= n/população*100000)
#letalidade
t2%>%group_by(municipio.x, semana)%>%summarise(letalidade= sum(n),
                                               "letalidade por 100k"= sum(`n/100k`))%>%arrange(municipio.x,semana)

     
     