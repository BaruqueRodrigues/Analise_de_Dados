
devtools::install_github("JaseZiv/worldfootballR")

library(worldfootballR)
br<-"https://fbref.com/en/comps/24/schedule/Serie-A-Scores-and-Fixtures"
worldfootballR::
  test<- get_match_urls(country = "BRA", gender = "M", season_end_year = 2019,
                        tier = "1st")
test<-
  get_advanced_match_stats(test,stat_type = "misc", team_or_player = "player")
urls <- get_match_urls(country = "ENG", gender = "M", season_end_year = 2020, tier = "1st")
urls
a<-get_advanced_match_stats(match_url=urls,stat_type="possession",team_or_player="player")
A<-get_match_summary(urls)
b<-get_match_summary(test)

View(b)

install.packages("rvest")
url<- "https://pt.wikipedia.org/wiki/%C3%93scar"
library(rvest)
library(dplyr)
library(xml2)


urlTables<-url%>%read_html()%>%html_nodes("table")
urlLinks<-url%>%read_html()%>%html_nodes("link")
filmesPremiados<-as.data.frame(html_table(urlTables[5]))

resultadosBrasileirão<-read_html("https://www.cbf.com.br/")

resultadosBrasileirão <-resultadosBrasileirão%>%html_nodes(".swiper-slide")

rodada<-resultadosBrasileirão%>% html_nodes(".aside-header .text-center")%>%
  html_text()
resultados<-resultadosBrasileirão%>% html_nodes(".aside-content .clearfix")%>%
  html_text()
mandante<-resultadosBrasileirão%>% html_nodes(".pull-left .time-sigla")%>%
  html_text()
visitante<-resultadosBrasileirão%>% html_nodes(".pull-right .time-sigla")%>%
  html_text()

tabelaBrasileirao<-data.frame(rodada=rodada,
                              mandante=mandante,
                              visitante=visitante
)

#read,csv
dados <- read.csv2("http://www.leg.ufpr.br/~fernandomayer/dados/crabs.csv")
#read table
dados2<-read.table("http://www.leg.ufpr.br/~paulojus/dados/gam01.txt")
#json
dados_json<-rjson::fromJSON("http://api.worldbank.org/country?per_page=10&region=OED&lendingtype=LNX&format=json")

sinistrosRecife2020Raw <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')

sinistrosRecife2020Raw <- sinistrosRecife2020Raw[-1:-10,]

sinistrosRecife2020RawNEW <- read.csv2('http://dados.recife.pe.gov.br/dataset/44087d2d-73b5-4ab3-9bd8-78da7436eed1/resource/fc1c8460-0406-4fff-b51a-e79205d1f1ab/download/acidentes_2020-novo.csv', sep = ';', encoding = 'UTF-8')
#tent1
(sinistrosRecife2020RawNEW$descricao %in% sinistrosRecife2020Raw$descricao)


#tent2
sinistrosRecife2020Raw$id<-seq_len(nrow(sinistrosRecife2020Raw))
sinistrosRecife2020Raw <- sinistrosRecife2020Raw[-1:-10,]
sinistrosRecife2020RawNEW$id<-seq_len(nrow(sinistrosRecife2020RawNEW))
(sinistrosRecife2020Raw$id %in% sinistrosRecife2020RawNEW$id)


sinistrosRecife2020Raw$chave2<-apply(sinistrosRecife2020Raw[, c(1,2,3)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

sinistrosRecife2020RawNEW$chave2<-apply(sinistrosRecife2020RawNEW[, c(1,2,3)], MARGIN = 1, FUN = function(i) paste(i, collapse = ""))

(sinistrosRecife2020RawNEW$chave2 %in% sinistrosRecife2020Raw$chave2)

setdiff(sinistrosRecife2020Raw,sinistrosRecife2020RawNEW)

#teste em um site votlado pra webscrap  
site<-read_html("https://webscraper.io/test-sites/e-commerce/allinone")
site<-site%>%html_nodes(".row")

desc_site<-site%>%html_nodes(".caption .description")%>%html_text()

titulo_site<-site%>%html_nodes(".caption .title")%>%html_text()
dfSite<-data.frame(descricacao=desc_site,
                   titulo=titulo_site)

amazon<-read_html("https://www.amazon.com.br/s?k=whey+protein&page=2&__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&qid=1620014674&ref=sr_pg_2")
amazon<-amazon%>%html_nodes(".sg-col-inner")
produto<-amazon%>%html_nodes("[class='a-size-base-plus a-color-base a-text-normal']")%>%html_text()
preco<-amazon%>%html_nodes("[class='a-offscreen']")%>%html_text()

dados_amazon<-data.frame(produto=produto,
                         preco=preco)
produto
preco
#ia fazer um scrap por página na amazon, mas desisti.
