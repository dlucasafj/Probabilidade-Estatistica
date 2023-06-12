# Arquivo para agrupar as funções que servem às funções principais #

# Função para agrupar as diferentes faixas de rendas
def categorizar_renda(valor):
    # Se o tipo for inteiro, vai categorizar como abaixo
    if type(valor) == int:
        if valor <= 3000:
            return 'Até 3000'
        elif valor <= 8000:
            return '3000 a 8000'
        else:
            return 'Mais de 8000'

    #Se for uma string, vai tratar como abaixo
    else:
        return valor

def mesclar_tabelas(nome_tabela_1, nome_tabela_2, database):
    # Mesclar as informações das colunas
    tabela_mesclada = database[[nome_tabela_1, nome_tabela_2]].copy()
    return tabela_mesclada