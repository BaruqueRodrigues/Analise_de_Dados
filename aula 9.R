#Aula 9

#librarys
library(tidyverse)#manipular, visualizar dados
library(DataExplorer)#fast EDA
library(validate)
#Dados
gss_cat%>%glimpse()

#Reporte de Analise Exploratória dos dados
gss_cat%>%create_report(
          output_file = "aula_9",
          y = "rincome",
          report_title = "Reporte de Analise Exploratória dos dados"
)

#Introdução dos Dados
gss_cat%>%introduce()

gss_cat%>%plot_intro()

#Dados Ausentes
gss_cat%>%plot_missing()

gss_cat%>%profile_missing()

#Exploração para variáveis continuas
gss_cat%>%plot_density()

gss_cat%>%plot_histogram()

#Exploração para variáveis categoricas
gss_cat%>%plot_bar()

#Exploração das Relações entre variáveis
gss_cat%>%plot_correlation()


# Pivoteando
print(fish_encounters)

fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)
#removendo dados NA
fish_encounters %>%
  pivot_wider(names_from = station, values_from = seen)%>%
  drop_na()
#PS nesse caso não fez sentido já que para esse dataset os valores de NA eram representados por 0

a<-fish_encounters%>%group_by(station)%>%summarise(sum(seen))
#removendo os casos que são diferentes não são Release
a%>%filter(station=="Release")

#join e validação

a<-poliscidata::world
a<-a%>%select(country,gini10,regime_type3)

b<-readxl::read_excel("dados_merge.xls")
b<-b%>%filter(year == 2010)%>%
  select(country,polcomp)

c<-left_join(a,b, by="country")
c<-c%>%drop_na()
valid<-validator(gini10 >0, regime_type3 !=is.na(regime_type3), polcomp != is.na(polcomp))
confront(c, valid)  
