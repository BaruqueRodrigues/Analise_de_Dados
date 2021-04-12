#####################Script da aula 12/04/2021
###########Tipos de Objetos
ranking_clubs<-data.frame(time = c("Flamengo","Palmeiras",
                                 "São Paulo", "Cruzeiro",
                                 "Santos", "Corinthians"),
                          nacionais = c(14,15,6,10,9,11),
                          internacionais = c(6,4,12,7,8,4),
                          total = c(20,19,18,17,17,15))
#############Simulações e Sequências
hist(rnorm(100,mean = 50, sd= 12.5))
hist(rnbinom(100,size = 2, prob = .6))

#quantidade de palavras que um bebe repete por mês, totalmente tirado da minha cabeça
View(data.frame(dia = seq(1:31),         
           papai = rep(c(1,2,3), times =c(14,10,7)),
           mamae = rep(c(3,4,5), times =c(7,10,14)),
           nana = rep(c(5,7,8), times =c(8,9,14))
                ))

##########Amostragem

amostragem <- addTaskCallback(function(...) {set.seed(123);TRUE});amostragem

dist_norm<-rnorm(250);summary(dist_norm)
#simulacao de resultado do jogos do brasileirao em pandemia
brasileirao2020<-data.frame(sit=rep(c("m", "v"), 20),
           flamengo=rep(rbinom(40, 2, 0.68)),
           vasco=rep(rbinom(40,2, 0.4)))
# sample
mean(sample(dist_norm, 30, replace = F));mean(dist_norm)
#bootstrap

bootsDistnorm<-replicate(10, sample(dist_norm, 30, replace = T))
#comparando médias
mean(bootsDistnorm);mean(dist_norm)
#instalando caret p fazer o split na amostra
install.packages("caret")
#usando a função
caret::createDataPartition(1:length(dist_norm), p=.8)

#centralizando uma distribuição poisson

poisson_d<-rpois(40, 2)
poisson_d_cent<- poisson_d-mean(poisson_d)
par(mfrow=c(1,2))
hist(poisson_d);hist(poisson_d_cent)

#Indexação. Indexando o melhor time br2019-2020
ranking_clubs[1,1]

#Estrutura de controle para o verdadeiro campeão de 87

campeao_87<-"Flamengo"
if (campeao_87 == "sport Recife") {
print("Sport Ganhou a série B")  
}else{print("O campeão de 87 é o flamengo")}


for (i in 1:40) {
  if (brasileirao2020[i,2]>=brasileirao2020[i,3]) {
    brasileirao2020[i,4]<-"flamengo maior"
  }else{
    brasileirao2020[i,4]<-"flamengo menor"
  }
}
 

#função básica

ex <- function(x){
   if (x<2021){
     if(x>1900){if(x %in% c(1980, 1982,
           1983, 1987,
           1992, 2009,
           2019, 2020)) {cat("do mengão")} else {
    cat("Outro levou")} }else{cat("nem tinha futebol")}
     }else{cat("vai ser do mengao")} 
  }



ex(2022)

#função sapply

sapply(brasileirao2020[2:3], barplot)
