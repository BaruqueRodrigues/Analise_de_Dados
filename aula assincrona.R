#1. Crie um data frame com pelo menos 500 casos e a seguinte composição: duas variáveis normais
#de desvio padrão diferente, uma variável de contagem (poisson),
#uma variável de contagem com dispersão (binomial negativa), uma variável binomial (0,1),
#uma variável qualitativa que apresenta um valor quando a variável binomial é 0 e outro quando é 1,
#e uma variável de index. 

#2. Centralize as variáveis normais. 
#3. Troque os zeros (0) por um (1) nas variáveis de contagem. 
#4. Crie um novo data.frame com amostra (100 casos) da base de dados original.
amostragem <- addTaskCallback(function(...) {set.seed(123);TRUE});amostragem

df<-data.frame(vnomr1=rnorm(500, mean = 250, sd =120),
           vnorm2=rnorm(500, mean = 250, sd =125),
           vpois=rpois(500,1),
           vnbinom=rnbinom(500,size = 2, prob = .5),
           vbinom=rbinom(1:500,1,.8),
           outra=rep(c("A", "B"),times =c(170,330), 500))

df$quali<-ifelse(df$vbinom==0,"zero","um")
