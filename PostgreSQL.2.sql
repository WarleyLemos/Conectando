import sqlite3
from datetime import datetime

# Conectar ao banco de dados (ou criar se não existir)
conn = sqlite3.connect('empresa_vendas.db')
cursor = conn.cursor()

# Criar a tabela 'produtos'
cursor.execute('''
CREATE TABLE IF NOT EXISTS produtos (
    id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    preco REAL NOT NULL
)
''')

# Criar a tabela 'compras'
cursor.execute('''
CREATE TABLE IF NOT EXISTS compras (
    id INTEGER PRIMARY KEY,
    produto_id INTEGER,
    quantidade INTEGER,
    data_compra TEXT,
    FOREIGN KEY (produto_id) REFERENCES produtos (id)
)
''')

# Inserir dados de exemplo na tabela 'produtos'
cursor.executemany('''
INSERT INTO produtos (nome, preco) VALUES (?, ?)
''', [
    ('Produto A', 10.0),
    ('Produto B', 20.0),
    ('Produto C', 30.0)
])

# Inserir dados de exemplo na tabela 'compras'
cursor.executemany('''
INSERT INTO compras (produto_id, quantidade, data_compra) VALUES (?, ?, ?)
''', [
    (1, 5, '2024-06-24'),
    (2, 3, '2024-06-24'),
    (3, 2, '2024-06-24'),
    (1, 1, '2024-06-23'),
    (2, 2, '2024-06-23')
])

# Criar a procedure para gerar o relatório diário
cursor.execute('''
CREATE PROCEDURE IF NOT EXISTS gerar_relatorio_diario(data TEXT)
BEGIN
    SELECT p.nome, SUM(c.quantidade) AS quantidade_vendida
    FROM compras c
    JOIN produtos p ON c.produto_id = p.id
    WHERE c.data_compra = data
    GROUP BY p.nome;
END;
''')

# Commit e fechar a conexão
conn.commit()
conn.close()

# Função para chamar a procedure e exibir o relatório
def gerar_relatorio_diario(data):
    conn = sqlite3.connect('empresa_vendas.db')
    cursor = conn.cursor()
    
    cursor.execute('''
    SELECT p.nome, SUM(c.quantidade) AS quantidade_vendida
    FROM compras c
    JOIN produtos p ON c.produto_id = p.id
    WHERE c.data_compra = ?
    GROUP BY p.nome
    ''', (data,))
    
    relatorio = cursor.fetchall()
    conn.close()
    
    return relatorio

# Exemplo de uso da função
data_hoje = datetime.now().strftime('%Y-%m-%d')
relatorio = gerar_relatorio_diario(data_hoje)
for linha in relatorio:
    print(f"Produto: {linha[0]}, Quantidade Vendida: {linha[1]}")