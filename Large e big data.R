library(data.table)

#vou usar os dados do microdados do enem, por quê é o que large data que eu lembro
enderecobase <- "C:/Users/55829/Desktop/SUP_ALUNO_2019.CSV"

# medindo extração 1 (via amostragem com read.csv)

base1 <- read.csv2(enderecobase, nrows=20, sep = "|")  

AmostraClasses <- sapply(base1, class) # encontra a classe da amostra

# base original e nova coluna de classes
system.time(read.csv2("C:/Users/55829/Desktop/SUP_ALUNO_2019.CSV",
                      colClasses = AmostraClasses))  

# medindo a função fread
base2 <- fread(enderecobase)
system.time(fread(enderecobase))


library(ff)
base <- read.csv.ffdf(file=enderecobase)         
system.time(read.csv.ffdf(file=enderecobase))

# operações

sum(base[,5])

base[,2]/base3[,1]

mean(base[ ,1])

median(base[ ,1])

baseamostra <- base[sample(nrow(base), 100000) , ]

lm(c ~ ., baseamostra)