#exercício da aula 10, fatores, data.table e dplyr

#criando um objeto
cores<-seq(1:7)

#objeto com as cores
rec<-letters[seq(1,7)]
#recodificando em factor
cores<-factor(cores, rec, rec)
#lidando com fatores, one hot encoding e binarização


a<-poliscidata::nes[1:10]


fac<-unlist(lapply(a, is.factor))
fac<-a[ ,fac]

a2<-ade4::acm.disjonctif(fac)
#frequencia das categorias 
forcats::fct_count(fac$abortpre_4point)
#reclassificação por ocorrencia
forcats::fct_lump(fac$abortpre_4point, 3)
#limpando a stagin area
rm(list=ls())
#uso do data.table
library(tidyverse)
library(data.table)
#rodando lm no data.table

####puxando a base
library(haven)
url <- "https://github.com/MartinsRodrigo/Analise-de-dados/raw/master/04622.sav"

download.file(url, "banco.sav", mode = "wb")

a

a <-read_sav("banco.sav") %>% mutate_all(zap_label)


#limpando a base
a <- a %>% 
  select(Q1607, Q18, Q1501, D1A_ID, D9, D2_SEXO, D12A) %>%
  filter(Q1607 <= 10,
         D9 < 9999998,
         Q1501 <= 10,
         Q18 <= 10,
         D12A < 8) %>%
  mutate(D2_SEXO = as_factor(D2_SEXO),
         D12A = as_factor(D12A),
         Q18 = zap_labels(Q18),
         Q1501 = zap_labels(Q1501))
#transformando em dt
a<-a%>%setDT()
#lm
a[,lm(Q1607 ~ Q18 + Q1501 + D1A_ID + D9 + D12A + D2_SEXO)]

#manipulação

a %>% filter(Q18>6)%>%#filtre os individuos com conservadorismo menor q 6
      group_by(D2_SEXO)%>%#agrupe por sexo
      summarise("apoio bolsonaro"=mean(Q1607))#dê a média de aprovação ao bolsonaro
