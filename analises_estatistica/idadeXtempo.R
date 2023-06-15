library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acessar as colunas "IDADE" e "HR_CONECTADO" no objeto de dados
idade <- as.numeric(planilha$IDADE)
hr_conectado <- as.numeric(planilha$HR_CONECTADO)

# Verificar se há valores ausentes nos dados
dados_incompletos <- is.na(idade) | is.na(hr_conectado)
idade <- idade[!dados_incompletos]
hr_conectado <- hr_conectado[!dados_incompletos]

# Criar um novo dataframe com as informações de idade e tempo conectado
dados <- data.frame(IDADE = idade, HR_CONECTADO = hr_conectado)

# Definir as faixas de idade
faixas_idade <- c("18-22", "22-26", "26-30", "30+")

# Criar um vetor vazio para armazenar as médias de tempo conectado
medias_tempo_conectado <- numeric(length(faixas_idade))

# Calcular a média de tempo conectado para cada faixa de idade
for (i in 1:length(faixas_idade)) {
  faixa <- faixas_idade[i]
  
  if (faixa == "30+") {
    medias_tempo_conectado[i] <- mean(dados$HR_CONECTADO[dados$IDADE >= 30], na.rm = TRUE)
  } else {
    medias_tempo_conectado[i] <- mean(dados$HR_CONECTADO[dados$IDADE >= as.numeric(substr(faixa, 1, 2)) & dados$IDADE <= as.numeric(substr(faixa, 4, 6))], na.rm = TRUE)
  }
}


# Criar o gráfico de barras invertido
grafico <- barplot(medias_tempo_conectado, horiz = TRUE, beside = TRUE,
                   ylab = "Faixa de Idade", xlab = "Média de Tempo Conectado",
                   main = "Média de Tempo Conectado por Faixa de Idade",
                   las = 1, cex.names = 0.8)

# Adicionar as faixas de idade ao lado das barras correspondentes
axis(2, at = grafico, labels = faixas_idade, tick = FALSE, line = 0.5)

# Adicionar a média de tempo conectado acima das barras correspondentes
for (i in 1:length(grafico)) {
  text(x = medias_tempo_conectado[i], y = grafico[i] + 0.5, labels = round(medias_tempo_conectado[i], 2), pos = 4, xpd = TRUE, cex = 0.8)
}
