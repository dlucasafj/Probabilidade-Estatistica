library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acesse as colunas "Semestre" e "FREQ_ON" no objeto de dados
semestre <- planilha$SEM
freq_online <- as.factor(planilha$FREQ_ON)

# Definir os rótulos das categorias da coluna "FREQ_ON"
labels_freq <- c("Raramente", "Ocasionalmente", "Frequentemente", "Quase sempre", "Sempre", "Não se aplica")

# Criar um novo dataframe com as colunas de relação
relacao_sem_freq <- data.frame(SEM = factor(semestre), FREQ_ON = factor(freq_online, labels = labels_freq))

# Contar a frequência de cada combinação de semestre e frequência online
contagem <- table(relacao_sem_freq)

# Definir as cores para cada frequência online
cores_freq <- c("#FF9999", "#FFCC99", "#FFFF99", "#99FF99", "#99CCFF", "#CCCCCC")

# Criar o gráfico de barras invertido
grafico <- barplot(t(contagem), horiz = TRUE, beside = TRUE, 
                   ylab = "Semestre", xlab = "Contagem",
                   main = "Relação entre Semestre e Frequência Online",
                   col = cores_freq, las = 1, cex.names = 0.8)

# Criar a legenda com as cores e frequências online correspondentes
legenda <- paste(labels_freq)
legend("topright", legend = legenda, fill = cores_freq, border = NA, bty = "n", text.col = "black", cex = 0.6)
