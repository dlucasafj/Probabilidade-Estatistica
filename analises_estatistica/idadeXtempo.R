library(readxl)

# Carregar a planilha especificando a planilha "Microdados Num"
planilha <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

# Acesse as colunas "IDADE" e "HR_CONECTADO" no objeto de dados
idade <- planilha$IDADE
hr_conectado <- as.numeric(planilha$HR_CONECTADO)

# Criar os intervalos de idade e tempo
intervalos_idade <- cut(idade, breaks = c(18, 22, 26, 30, Inf), labels = c("18-22", "22-26", "26-30", "30+"))
intervalos_tempo <- cut(hr_conectado, breaks = c(0, 3, 6, 12, Inf), labels = c("0-3h", "3-6h","6-12h", "+12h"))

# Criar um novo dataframe com os intervalos de idade e tempo
relacao_intervalos <- data.frame(IDADE = factor(intervalos_idade), HR_CONECTADO = factor(intervalos_tempo))

# Contar a frequência de cada combinação de faixa de idade e tempo
contagem <- table(relacao_intervalos)

# Definir as cores para cada faixa de tempo
cores_tempo <- c("red", "yellow", "green", "blue")

# Criar o gráfico de barras invertido
grafico <- barplot(t(contagem), horiz = TRUE, beside = TRUE, 
                   ylab = "Faixa de Idade", xlab = "Contagem",
                   main = "Relação entre Tempo Online e Faixa de Idade",
                   col = cores_tempo, las = 1, cex.names = 0.8)


# Adicionar os nomes das faixas de tempo ao lado das barras correspondentes
nomes_tempo <- c("0-3h", "3-6h","6-12h", "+12h")

# Criar a legenda com as cores e faixas de tempo correspondentes
legenda <- paste(nomes_tempo)
legend("topright", legend = legenda, fill = cores_tempo, border = NA, bty = "n", text.col = "black", cex = 0.8)
