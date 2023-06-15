library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acesse as colunas "REND_SAL_MIN" e "COMPRAS_ON" no objeto de dados
renda_sal_min <- planilha$RENDA_SAL_MIN
compras_on <- planilha$COMPRAS_ON

# Criar um novo dataframe com as colunas "REND_SAL_MIN" e "COMPRAS_ON"
relacao_renda_compras <- data.frame(REND_SAL_MIN = factor(renda_sal_min, levels = 0:4, labels = c("Não sei", "Até 1", "Até 2", "Até 3", "Até 4")),
                                    COMPRAS_ON = factor(compras_on, levels = 1:2, labels = c("Não", "Sim")))

# Contar a frequência de cada combinação de faixa de renda e compras online
contagem <- table(relacao_renda_compras)

# Definir as cores para cada resposta de compras online
cores_compras <- c("red", "green")

# Criar o gráfico de barras horizontais invertido
grafico <- barplot(t(contagem), horiz = TRUE, beside = TRUE,
                   ylab = "Faixa de Renda (Em salários mínimos)", xlab = "Contagem",
                   main = "Relação entre Renda Familiar e Compras Online",
                   col = cores_compras, las = 1, cex.names = 0.7)

# Criar a legenda com as cores e respostas de compras online correspondentes
legend("bottomright", legend = levels(relacao_renda_compras$COMPRAS_ON), fill = cores_compras, border = NA, bty = "n", text.col = "black", cex = 0.8)
