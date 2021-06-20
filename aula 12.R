library(dplyr)
library(fuzzyjoin)

a<-data.frame(
time = c("Flamengo", "Vasco", "Botafogo", "Flores"),
divisao = c("Serie A", "Série B", "Série B","Serie A"),
libertadores = c("bicampeao", "campeao1", "cheirin", "cheirin"),
mundial = c("campeao", "sem mundial", "sem mundial", "sem mundial"))

b<-data.frame(
time = c("Flamengoo", "Vascu", "Botaflop", "flores"),
teve_zico = c("sim","não","não","não"))



c <- stringdist_join(a, b, mode='left')


c <- c %>% mutate(serieA_2020 = ifelse(grepl(paste("Serie A", collapse="|"), divisao), 'segue', 'rebaixado'))
