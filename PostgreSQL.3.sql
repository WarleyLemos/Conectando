import sqlite3

from datetime import datetime

# Conectar ao banco de dados (ou criar se não existir)

conn = sqlite3.connect('loja.db')

cursor = conn.cursor()

# Criar a tabela 'clientes'

cursor.execute('''

CREATE TABLE IF NOT EXISTS clientes (

    id INTEGER PRIMARY KEY,

    nome TEXT NOT NULL,

    email TEXT NOT NULL,

    data_cadastro TEXT NOT NULL

)

''')

# Inserir dados de exemplo na tabela 'clientes'

cursor.executemany('''

INSERT INTO clientes (nome, email, data_cadastro) VALUES (?, ?, ?)

''', [

    ('Cliente A', 'clienteA@example.com', '2024-06-24'),

    ('Cliente B', 'clienteB@example.com', '2024-06-24'),

    ('Cliente C', 'clienteC@example.com', '2024-06-23'),

    ('Cliente D', 'clienteD@example.com', '2024-06-23'),

    ('Cliente E', 'clienteE@example.com', '2024-06-24')

])

# Commit e fechar a conexão

conn.commit()

conn.close()

# Função para contar clientes cadastrados em um dia específico

def contar_clientes_dia(data):

    conn = sqlite3.connect('loja.db')

    cursor = conn.cursor()

    

    cursor.execute('''

    SELECT COUNT(*)

    FROM clientes

    WHERE data_cadastro = ?

    ''', (data,))

    

    resultado = cursor.fetchone()[0]

    conn.close()

    

    return resultado

# Exemplo de uso da função

data_hoje = '2024-06-24'

total_clientes = contar_clientes_dia(data_hoje)

print(f"Total de clientes cadastrados em {data_hoje}: {total_clientes}")