# carrega a base de snistros de transito do site da PCR
sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2021Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/2caa8f41-ccd9-4ea5-906d-f66017d6e107/download/acidentes_2021-jan.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2019Raw <- read.csv2("http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/3531bafe-d47d-415e-b154-a881081ac76c/download/acidentes-2019.csv", sep = ';', encoding = 'UTF-8')

# junta as bases de dados com comando rbind (juntas por linhas)
names(sinistrosRecife2019Raw);names(sinistrosRecife2020Raw)
sinistrosRecife2019Raw[10:12]<-NULL
names(sinistrosRecife2019Raw)<-names(sinistrosRecife2020Raw)
sinistrosRecifeRaw <- rbind(sinistrosRecife2020Raw, sinistrosRecife2021Raw,sinistrosRecife2019Raw)

# observa a estrutura dos dados
str(sinistrosRecifeRaw)

# modifca a data para formato date
sinistrosRecifeRaw$data <- as.Date(sinistrosRecifeRaw$data, format = "%Y-%m-%d")

# modifica natureza do sinistro de texto para fator
sinistrosRecifeRaw$natureza_acidente <- as.factor(sinistrosRecifeRaw$natureza_acidente)


# cria funçaõ para substituir not available (na) por 0
naZero <- function(x) {
  x <- ifelse(is.na(x), 0, x)
}

for (itm in ls()) { 
  print(formatC(c(itm, object.size(get(itm))), 
                format="d", 
                width=30), 
        quote=F)
}
gc()
#os obj que usavam mais memoria eram sinistrosRecifeRaw e sinistrosRecife2019Raw
rm(list=c("sinistrosRecife2019Raw","sinistrosRecife2021Raw","sinistrosRecife2020Raw", "itm"))
# aplica a função naZero a todas as colunas de contagem
sinistrosRecifeRaw[, 15:25] <- sapply(sinistrosRecifeRaw[, 15:25], naZero)

# exporta em formato nativo do R
saveRDS(sinistrosRecifeRaw, "sinistrosRecife.rds")

# exporta em formato tabular (.csv) - padrão para interoperabilidade
write.csv2(sinistrosRecifeRaw, "sinistrosRecife.csv")
# carrega base de dados em formato nativo do R .rds - vantagem: eficiência computacional, usa menos memória ram
#desvantagem, é nativa do R.
sinistrosRecife <- readRDS('sinistrosRecife.rds')

# carrega base de dados em formato tabular (.csv) - vantagem: interoperabilidade, roda em qualquer linguagem,
#sem ser específica de um software, todavia perde velocidade computacional
sinistrosRecife <- read.csv2('sinistrosRecife.csv', sep = ';')

install.packages("microbenchmark")
library(microbenchmark)
library(openxlsx)
library(readxl)
write.xlsx(sinistrosRecife, "sinistrosRecife.xlsx")

#rodando o teste entre as duas funções
microbenchmark(a=saveRDS(sinistrosRecifeRaw, "sinistrosRecife.rds"),
               b=write.csv2(sinistrosRecifeRaw, "sinistrosRecife.csv"),
               c=write.xlsx(sinistrosRecife, "sinistrosRecife.xlsx"),
               times = 30L)
#vemos que a função a tem uma média quase 5 vezes mais rápida
microbenchmark(a=readRDS('sinistrosRecife.rds'),
               b=read.csv2('sinistrosRecife.csv', sep = ';'),
               c=read_excel("sinistrosRecife.xlsx"),
               times = 10L)
#vemos após executar a funão microbenchmark que o tempo de execucação de leitura da função da função
#readRDS é 5x mais rápida que a função readxl, e 60% mais rápida que a função read.csv
#apesar da velocidade de leitura e carregamento dessa função ser vantajosa, em termos de eficiência computacional
#por ela trabalhar com objetos que são nativos do R é problematico. A função read.csv2 permite uma maior
#interoperabilidade, permitindo que arquivos separados por virgula sejam lidos por qualquer software