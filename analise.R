##################
#Chamadar pacote #
##################                
library(readxl) #importar banco em excel
library(descr)#crosstable

View(dados)
fix(dados)
names(dados)


attach(dados)
###########################
#Frequencia das Variaveis
###########################
table(SEXO)
table(SEM)
table(RENDA_SAL_MIN)
table(PERIODO)
table(STATUS_SEM)
table(STATUS_TRABALHO)
table(MORADIA)

table(DISPOSITIVO)
table(TRABALHO_ON)
table(AMIGOS_ON)        
table(NOTICIAS_ON)     
table(COMPRAS_ON)       
table(VIDEOS_ON)        
table(JOGOS_ON)

table(R_SOCIAL)
table(REPRE_COMPUTADOR) 
table(REL_INFORMATICA)
table(STATUS_SEM)
table(FREQ_ON)
table(FREQ_ATV_DOM)
table(FREQ_QUEIXAS_ON)  
table(FREQ_R_SOCIAIS)   
table(FREQ_SONO)
table(FREQ_INTROV)
table(FREQ_EMOCIONAL)   
table(FREQ_MENOS_ON)
pie(table(RENDA_SAL_MIN), main = "Renda Familiar - Salarios Minimos",labels = c("Nao Sei","Ate 1", "Ate 2", "Ate 3", "4 ou mais"))

####Distribuicao Percentual######
prop.table(table(SEXO))*100
prop.table(table(SEM))*100
prop.table(table(RENDA_SAL_MIN))*100
prop.table(table(PERIODO))*100
prop.table(table(STATUS_SEM))*100
prop.table(table(STATUS_TRABALHO))*100
prop.table(table(MORADIA))*100

######################
#Medidas descritivas #
######################
summary(IDADE)
summary(HR_ESTUDO)
summary(HR_ESTUDO_ON)
summary(HR_CONECTADO)

summary(dados)

mean(IDADE) #Media
median(IDADE) #Mediana

#Distribuição de frequencia IDADE
nclasses <- sqrt(length(IDADE))
intervalo <- diff(range(IDADE, na.rm=T))/round(nclasses)
age <- seq(18, 58, round(intervalo))

classes<-c("18-23","23-28","28-33","33-38","39-43", "43-48", "48-53", "53-58")

tab_age <-table(cut(IDADE,breaks=age,right=FALSE,labels=classes))
tab_age

# Distribuicao Frequencia Absoluta Grafico de Barras
distri <- barplot(tab_age,ylab="Frequencia", xlab = "Faixa Etaria")

# Distribuicao percentual Grafico de Barras
tab_age_per = prop.table(tab_age)*100
tab_age_per
distri2 <- barplot(tab_age_per, ylab="Frequencia", xlab = "Faixa Etaria")


### Medidas de dispersao######

range(IDADE) #Valor minimo e maximo
diff(range(IDADE, na.rm=T)) #Diferenca entre o maior o menor valor
sd(IDADE) #Desvio padrao
var(IDADE)#Variancia
cv=sd(IDADE)/mean(IDADE)*100 #coeficiente de variacao
cv

range(HR_ESTUDO, na.rm=T)
diff(range(HR_ESTUDO, na.rm=T))
sd(HR_ESTUDO, na.rm=T) #Desvio padrao
var(HR_ESTUDO, na.rm=T)#Variancia
cv=sd(HR_ESTUDO, na.rm=T)/mean(HR_ESTUDO, na.rm=T)*100 #coeficiente de variacao
cv

range(HR_ESTUDO_ON, na.rm=T)
diff(range(HR_ESTUDO_ON, na.rm=T))
sd(HR_ESTUDO_ON, na.rm=T) #Desvio padrao
var(HR_ESTUDO_ON, na.rm=T)#Variancia
cv=sd(HR_ESTUDO_ON, na.rm=T)/mean(HR_ESTUDO_ON, na.rm=T)*100 #coeficiente de variacao
cv

range(HR_CONECTADO, na.rm=T)
diff(range(HR_CONECTADO, na.rm=T))
sd(HR_CONECTADO) #Desvio padrao
var(HR_CONECTADO)#Variancia
cv=sd(HR_CONECTADO, na.rm=T)/mean(HR_CONECTADO, na.rm=T)*100 #coeficiente de variacao
cv


##Codificando variaveis numericas como categericas.
Jogos = factor(JOGOS_ON, levels = c(1,2),labels = c("Nao", "Sim")) # Colocando labels
Redes_S = factor(R_SOCIAL, levels = c(1,2),labels = c("Nao", "Sim")) # Colocando labels
Trabalha_on = factor(TRABALHO_ON, levels = c(1,2),labels = c("Nao", "Sim")) # Colocando labels

#Redes_S = factor(R_SOCIAL, levels = c(1,2,3,4,5,6),labels = c("Raram.", "Ocasi.", "Frequen.", "Qse Sempre", "Sempre", "N aplica")) # Colocando labels

table(Salarios_Min)

Sexo= factor(SEXO, levels = c(1,2),labels = c("Feminino", "Masculino")) 

tab_sex_renda = round(table(Sexo,Salarios_Min),2)
barplot(tab_sex_renda, ylab = "Freq")
prop.table(tab_sex_renda)


tapply(HR_ESTUDO_ON, Salarios_Min, mean, na.rm=T)
tapply(IDADE, Salarios_Min, mean, na.rm=T)
tapply(HR_ESTUDO_ON, Salarios_Min, mean, na.rm=T)

tapply(HR_ESTUDO_ON, list(IDADE<=24),summary)

# Relacao entre aluno que perdem o sono e jogam online
crosstab(Jogos, FREQ_SONO, prop.r = TRUE, plot = TRUE, col = c("black", "orange"))

# Relacao entre aluno que jogam online e que recebem queixas
crosstab(Jogos, FREQ_QUEIXAS_ON, prop.r = TRUE, plot = TRUE, col = c("black", "orange"))

# Relacao entre frequencia de consulta as redes sociais e alunos que consideram redes sociais toxicas
crosstab(Redes_S, FREQ_R_SOCIAIS, prop.r = TRUE, plot = TRUE, col = c("black", "orange"))

# Relacao entre a frequencia que alunos se sentem deprimidos quando nao estao onlie
# com os alunos que avaliam as redes sociais como toxicas
crosstab(Redes_S, FREQ_EMOCIONAL, prop.r = TRUE, plot = TRUE, col = c("black", "orange"))

# Relacao entre alunos que se sentem deprimidos sem estar online e tentam reduzir quantidade de tempo online    
crosstab(FREQ_EMOCIONAL, FREQ_MENOS_ON, prop.r = TRUE, plot = TRUE, col = c("gray", "orange","black", "red", "blue"))

tapply(HR_CONECTADO, Trabalha_on, mean, na.rm=T)

tapply(HR_CONECTADO, Jogos, mean, na.rm=T)

#table(DIETA,Social, IDADE>=28) #GRUPO COM IDADE MAIOR QUE 28
#crosstab(DIETA,Social,IDADE>=28, prop.r = TRUE, plot = FALSE)

###### TESTE Qui Quadrado######

Qui_quad_Renda = table(RENDA_SAL_MIN, REPRE_COMPUTADOR)
Qui_quad_Emocional = table(FREQ_EMOCIONAL,FREQ_MENOS_ON)
Qui_quad_Moradia = table(MORADIA,FREQ_QUEIXAS_ON)

chisq.test(Qui_quad_Renda)
chisq.test(Qui_quad_Emocional)
chisq.test(Qui_quad_Moradia)


