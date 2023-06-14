library("readxl")
library("ggplot2")
library("ggthemes")
library("descr")
meus_dados <- read_excel("database_numerica.xlsx", sheet = "Microdados Num")

###################
# VARIÁVEL IDADE  #
###################
IDADE = meus_dados$IDADE
df = data.frame(idade=IDADE,sexo=meus_dados$SEXO)
# Valor min e max

val <- range(meus_dados$IDADE) 
age_larger <- val[1]
age_small <- val[2]

ampli <- diff(range(IDADE)) # amplitude da idade
average_age <- mean(IDADE) # Media de idade
median_age <- median(IDADE) #Mediana da idade

# Quartis - Idade

q1 <- quantile(IDADE,probs = 0.25)
q2 <- quantile(IDADE, probs = 0.50)
q3 <- quantile(IDADE, probs = 0.75)

# Desvio Padrão

shunt_default_age <- sd(IDADE)

# Variância

variance_age <- var(IDADE)

# Coeficiente de variação

coefficient_age = sd(IDADE)/(mean(IDADE)*100)

#Sumario

summary(IDADE)

# Sumario da Idade por dispositivos
age_device=tapply(IDADE,meus_dados$DISPOSITIVO,summary)

#############################################
#Cruzando as variáveis Idade X Dispositivos #
#############################################

crosstab(IDADE,meus_dados$DISPOSITIVO,prop.r=TRUE,plot = FALSE) 

# Teste qui-quadrado

crosstab(IDADE,meus_dados$DISPOSITIVO,expected = FALSE,prop.r=TRUE,plot = FALSE,
         chisq = TRUE, fisher = TRUE) 
crosstab(IDADE,meus_dados$DISPOSITIVO,expected = TRUE,prop.r=TRUE,plot = FALSE,
         chisq = TRUE, fisher = TRUE) 

chisq.test(IDADE,meus_dados$DISPOSITIVO,simulate.p.value = TRUE)


#Grafico
plot(IDADE,meus_dados$DISPOSITIVO, main = "Distribuicao entre idade e dispositivos.", col="blue")
barplot (table (IDADE,meus_dados$DISPOSITIVO), ylab="Idade",xlab="dispositivos",ylim=c(0,30),beside=TRUE)

