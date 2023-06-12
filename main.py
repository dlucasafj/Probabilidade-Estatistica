# -*- coding: utf-8 -*-
import pandas as pd

database = pd.read_excel('database.xlsx')

columns_name = database.columns.ravel() # pega o nome de todas as colunas

data=[]

# Armazena num array de objetos o nome da coluna e seus valores
for column in columns_name: 
    data.append({
        'key': column,
        'value': database[column].tolist()
    })


print(data[0]['key']) # teste mostra nome coluna (para mostrar o valor basta substituir 'key' por 'value')
 