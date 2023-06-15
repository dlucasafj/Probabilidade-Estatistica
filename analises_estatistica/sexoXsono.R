library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acesse as colunas "Sexo" e "FREQ_SONO" no objeto de dados
sexo <- factor(planilha$SEXO, labels = c("Feminino", "Masculino"))
freq_sono <- factor(planilha$FREQ_SONO, labels = c("Raramente", "Ocasionalmente", "Frequentemente", "Quase sempre", "Sempre", "Não se aplica"))

# Criar um novo dataframe com as colunas de relação
relacao_sexo_sono <- data.frame(SEXO = sexo, FREQ_SONO = freq_sono)

# Contar a frequência de cada combinação de sexo e frequência de perda de sono
contagem <- table(relacao_sexo_sono)

# Definir as cores para cada frequência de perda de sono
cores_freq_sono <- c("#FF9999", "#FFCC99", "#FFFF99", "#99CC99", "#6699CC", "#CCCCCC")

# Criar o gráfico de barras horizontais
grafico <- barplot(t(contagem), horiz = TRUE, beside = TRUE,
                   ylab = "Sexo", xlab = "Contagem",
                   main = "Relação entre Sexo e Frequência de Perda de Sono",
                   col = cores_freq_sono, las = 1, cex.names = 0.8)

# Criar a legenda com as cores e frequência de perda de sono correspondente
legenda <- paste(levels(freq_sono))
legend("topright", legend = legenda, fill = cores_freq_sono, border = NA, bty = "n", text.col = "black", cex = 0.6)
