library(tidyverse)
library(stringr)
library(data.table)

#Extract the data

a <- fread("bases_originais/basegeral.csv")

#Treatment


a$dt_primeiros_sintomas <- Hmisc::impute(a$dt_primeiros_sintomas, "random")

#n de casos confirmados por municipio
a%>%group_by(classe, municipio)%>%count()

# Criando uma variável binária se o sintoma tem tosse ou não

a <- a %>% mutate(tosse = ifelse(grepl(paste("TOSSE", collapse="|"), sintomas), '1', '0'))


# Calculando casos confirmados e negativos tiveram tosse
neg2 <- as.data.table(table(base2$classe == "NEGATIVO" & base2$sintomas_tosse == 1, by = base2$municipio)) %>% 
  filter(V2 == T)

conf2 <- as.data.table(table(base2$classe == "CONFIRMADO" & base2$sintomas_tosse == 1, by = base2$municipio)) %>% 
  filter(V2 == T)

#Média Movel p negativos e confirmados

library(zoo)

base_neg <- a %>%
  arrange(as.Date(dt_notificacao)) %>% 
  filter(classe == "NEGATIVO") %>% 
  mutate(negativo_m = round(rollmean(x = table(classe), 7, align = "right", fill = NA), 2))

base_conf <- a %>%
  arrange(as.Date(dt_notificacao)) %>% 
  filter(classe == "CONFIRMADO") %>% 
  mutate(confirmado_m = round(rollmean(x = table(classe), 7, align = "right", fill = NA), 2))