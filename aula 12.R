library(dplyr)
library(fuzzyjoin)
a<-data.frame(x=LETTERS[seq(1,5)], z= seq(1:5))
b<-data.frame(X=letters[seq(1,5)], Z= seq(1:5))

a<-fuzzyjoin::stringdist_join(a,b, mode='left')
  
tse20A1 %>% mutate(tag_partido = ifelse(grepl(paste(partidos_bolsonaro, colapse="|"), COMPOSICAO_LEGENDA), 'bolso_t1', 'nao_bolso_t1'))
a<-data.frame(
time = c("Flamengo", "Vasco", "Botafogo", "Flores"),
divisao = c("Serie A", "Série B", "Série B","Serie A"),
libertadores = c("bicampeao", "campeao1", "cheirin", "cheirin"),
mundial = c("campeao", "sem mundial", "sem mundial", "sem mundial"))

b<-data.frame(
time = c("Flamengoo", "Vascu", "Botaflop", "flores"),
teve_zico = c("sim","não","não","não"))



c <- stringdist_join(a, b, mode='left')

# Criando uma nova base com nova variável dada a presença de uma categoria na variável 'curso'
c <- c %>% mutate(serieA_2020 = ifelse(grepl(paste("Serie A", collapse="|"), divisao), 'segue', 'rebaixado'))
