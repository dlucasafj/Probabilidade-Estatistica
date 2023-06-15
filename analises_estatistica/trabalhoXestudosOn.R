library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acessar as colunas "STATUS_TRABALHO" e "HR_CONECTADO" no objeto de dados
status_trabalho <- planilha$STATUS_TRABALHO
hr_conectado <- as.numeric(as.character(planilha$HR_CONECTADO))

# Criar um novo dataframe com as colunas "STATUS_TRABALHO" e "HR_CONECTADO"
relacao_trabalho_conectado <- data.frame(STATUS_TRABALHO = factor(status_trabalho, levels = 1:2, labels = c("Não", "Sim")),
                                         HR_CONECTADO = hr_conectado)

# Remover valores NA
relacao_trabalho_conectado <- relacao_trabalho_conectado[complete.cases(relacao_trabalho_conectado), ]

# Calcular a média de tempo conectado para cada categoria de trabalho
medias_conectado <- tapply(relacao_trabalho_conectado$HR_CONECTADO, relacao_trabalho_conectado$STATUS_TRABALHO, mean)

# Definir as cores para cada categoria de trabalho
cores_trabalho <- c("red", "green")

# Criar o gráfico de barras horizontais
grafico_conectado <- barplot(medias_conectado, horiz = TRUE, beside = TRUE,
                             ylab = "Status de Trabalho", xlab = "Média de Horas Conectado",
                             main = "Relação entre Status de Trabalho e Tempo Conectado",
                             col = cores_trabalho, las = 1, cex.names = 0.7)

# Remover o eixo X antigo e ajustar o novo eixo X
axis(1, at = NULL)
axis(1, at = c(0, 2, 4, 6, 8, 10), labels = c("0", "2", "4", "6", "8", "10"), pos = -0.5, tick = FALSE, line = 0)

# Adicionar a legenda
legend("bottomright", legend = levels(relacao_trabalho_conectado$STATUS_TRABALHO), fill = cores_trabalho, border = NA, bty = "n", text.col = "black", cex = 0.8)
