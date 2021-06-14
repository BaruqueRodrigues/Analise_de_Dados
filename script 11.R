####Script Aula 11 #####
library(tidyverse)
library(data.table)

### Missing Data ###
#load data
a <- poliscidata::world

#na check
a %>% funModeling::status()

#shadow matrix
a<-a%>%is.na() %>% 
    abs()  %>% 
    as.data.frame()

#teste de aleatoriedade
b <- a[which(sapply(a, sd) > 0)]#mantém apenas variáveis que possuem NA
b %>%  cor() #teste de aleatoriedade

rm(list=ls())#limpar a staging area
### Outliers ###
#load data
a <- rio::import('https://dados.seplag.pe.gov.br/apps/basegeral.csv')
#data wrangling
a <-a %>%
    count(municipio, sort = T, name = 'casos') %>% 
    mutate(casos2 = sqrt(casos), casosLog = log(casos))
#distancia interquartil
library(plotly)

plot_ly(y = a$casos2, type = "box",
        text = a$municipio, boxpoints = "all", jitter = 0.3)
boxplot.stats(a$casos2)$out
boxplot.stats(a$casos2, coef = 2)$out

Out <- boxplot.stats(a$casos2)$out
OutIndex <- which(a$casos2 %in% c(Out))
OutIndex

#filtro de hamper
lower_bound <- median(a$casos2) - 3 * mad(a$casos2, constant = 1)
upper_bound <- median(a$casos2) + 3 * mad(a$casos2, constant = 1)
(outlier_ind <- which(a$casos2 < lower_bound | a$casos2 > upper_bound))

# teste de Rosner
Rosner <- EnvStats::rosnerTest(a$casos2, k = 10)
Rosner
Rosner$all.stats

### Imputação ###

(ToothGrowthNASeed <- round(runif(10, 1, 50))) #criando valores aleatorios

(ToothGrowth$len[ToothGrowthNASeed] <- NA) #imputando NA

#imputação por tendencia central

library(Hmisc)
# Média
ToothGrowth$len <- impute(ToothGrowth$len, fun = mean)
#verificação
is.imputed(ToothGrowth$len) 
table(is.imputed(ToothGrowth$len))
#hotdeck
ToothGrowth$len[ToothGrowthNASeed] <- NA
library(VIM)
ToothGrowth2 <- kNN(ToothGrowth)
