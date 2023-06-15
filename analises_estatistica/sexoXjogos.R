library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acessar as colunas "Sexo" e "JOGOS_ON" no objeto de dados
sexo <- factor(planilha$SEXO, labels = c("Feminino", "Masculino"))
jogos_on <- factor(planilha$JOGOS_ON, labels = c("Não", "Sim"))

# Criar um novo dataframe com as colunas de relação
relacao_sexo_jogos <- data.frame(SEXO = sexo, JOGOS_ON = jogos_on)

# Contar a frequência de cada combinação de sexo e uso de jogos online
contagem <- table(relacao_sexo_jogos)

# Definir as cores para cada opção de uso de jogos online
cores_jogos_on <- c("#FF9999", "#99CC99")

# Criar o gráfico de barras horizontais
grafico <- barplot(t(contagem), horiz = TRUE, beside = TRUE,
                   ylab = "Sexo", xlab = "Contagem",
                   main = "Relação entre Sexo e Jogos Online",
                   col = cores_jogos_on, las = 1, cex.names = 0.8)

# Criar a legenda com as cores e opções de uso de jogos online correspondentes
legenda <- paste(levels(jogos_on))
legend("bottomright", legend = legenda, fill = cores_jogos_on, border = NA, bty = "n", text.col = "black", cex = 1)
