# -*- coding: utf-8 -*-
import pandas as pd
import matplotlib.pyplot as plt
import funcoes

database = pd.read_excel('database.xlsx')

columns_name = database.columns.ravel()  # pega o nome de todas as colunas

data = []

# Armazena num array de objetos o nome da coluna e seus valores
for column in columns_name:
    data.append({
        'key': column,
        'value': database[column].tolist()
    })

print(data[0]['key'])  # teste mostra nome coluna (para mostrar o valor basta substituir 'key' por 'value')


# Função para montar gráfico simples mostrando a quantidade de pessoas por sexo
def contagem_sexo():
    sexo = database['Sexo:'].value_counts()

    # Criar gráfico de barras com o Matplotlib
    fig, ax = plt.subplots()
    ax.bar(sexo.index, sexo.values)

    # Definir rótulos e título do gráfico
    ax.set_xlabel('Sexo')
    ax.set_ylabel('Quantidade')
    ax.set_title('Quantidade de pessoas por sexo')

    # Exibir o gráfico
    plt.show()


# Função para montar gráfico simples mostrando a quantidade de pessoas por semestre
def contagem_semestre():
    semestre = database['Semestre que está cursando:'].value_counts().sort_index()

    fig, ax = plt.subplots()
    ax.bar(semestre.index, semestre.values)

    ax.set_xlabel('Semestre')
    ax.set_ylabel('Quantidade')
    ax.set_title('Quantidade de pessoas por semestre')

    plt.show()


# Função para montar gráfico simples mostrando a quantidade de pessoas que trabalham
def contagem_se_trabalha():
    se_trabalha = database['Você trabalha?'].value_counts().sort_index()

    fig, ax = plt.subplots()
    ax.bar(se_trabalha.index, se_trabalha.values)

    ax.set_xlabel('Você trabalha?')
    ax.set_ylabel('Quantidade')
    ax.set_title('Quantidade de pessoas que trabalham')

    plt.show()


# Função para montar gráfico simples mostrando as faixas de renda, agrupadas em 4 grupos
def contagem_renda_familiar():
    database['renda_categorizada'] = database['Renda familiar'].apply(funcoes.categorizar_renda)
    contagem_renda = database['renda_categorizada'].value_counts().sort_index()

    fig, ax = plt.subplots()
    ax.bar(contagem_renda.index, contagem_renda.values)

    ax.set_xlabel('Faixa de Renda')
    ax.set_ylabel('Quantidade')
    ax.set_title('Quantidade de pessoas por faixa de renda')

    for i, v in enumerate(contagem_renda):
        ax.text(i, v + 1, str(v), ha='center', va='bottom')

    plt.show()


# Função para montar gráfico mostrando a média entre as horas de estudo em pessoas que trabalham/não trabalham
def media_estudos_por_trabalho():
    tabela_se_trabalha = "Você trabalha?"
    tabela_tempo_de_estudo = 'Tempo de estudo diário (horas):'
    tabela_mesclada = funcoes.mesclar_tabelas(tabela_se_trabalha, tabela_tempo_de_estudo, database)

    media_trabalhadores = tabela_mesclada[tabela_mesclada['Você trabalha?'] == 'Sim'][
        'Tempo de estudo diário (horas):'].mean()
    media_nao_trabalhadores = tabela_mesclada[tabela_mesclada['Você trabalha?'] == 'Não'][
        'Tempo de estudo diário (horas):'].mean()

    categorias = ['Não trabalham', 'Trabalham']
    medias = [media_nao_trabalhadores, media_trabalhadores]

    fig, ax = plt.subplots()
    ax.bar(categorias, medias)

    ax.set_xlabel('Situação de trabalho')
    ax.set_ylabel('Média de horas de estudo diário')
    ax.set_title('Média de horas de estudo por situação de trabalho')

    plt.show()


# Função para montar gráfico mostrando a média entre a renda familiar e o tipo de moradia da pessoa
def media_renda_por_moradia():
    database['Renda familiar'] = pd.to_numeric(database['Renda familiar'], errors='coerce')

    tabela_mora_com_quem = 'Mora com quem?'
    tabela_renda_familiar = 'Renda familiar'
    tabela_mesclada = funcoes.mesclar_tabelas(tabela_mora_com_quem, tabela_renda_familiar, database)

    media = tabela_mesclada.groupby('Mora com quem?')['Renda familiar'].mean()

    fig, ax = plt.subplots()
    ax.bar(media.index, media.values)

    ax.set_xlabel('Situação de Moradia')
    ax.set_ylabel('Média de Renda Familiar')
    ax.set_title('Relação entre Moradia e Renda Familiar')

    plt.show()


if __name__ == '__main__':
    contagem_sexo()
    contagem_semestre()
    contagem_se_trabalha()
    contagem_renda_familiar()
    media_estudos_por_trabalho()
    media_renda_por_moradia()