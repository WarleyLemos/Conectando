import sqlite3

# Conectar ao banco de dados (ou criar se não existir)

conn = sqlite3.connect('empresa.db')

cursor = conn.cursor()

# Criar a tabela 'departamentos'

cursor.execute('''

CREATE TABLE IF NOT EXISTS departamentos (

    id INTEGER PRIMARY KEY,

    nome TEXT NOT NULL,

    num_empregados INTEGER DEFAULT 0

)

''')

# Criar a tabela 'empregados'

cursor.execute('''

CREATE TABLE IF NOT EXISTS empregados (

    id INTEGER PRIMARY KEY,

    nome TEXT NOT NULL,

    idade INTEGER,

    departamento_id INTEGER,

    FOREIGN KEY (departamento_id) REFERENCES departamentos (id)

)

''')

# Criar um trigger que incrementa o número de empregados no departamento ao inserir um novo empregado

cursor.execute('''

CREATE TRIGGER IF NOT EXISTS incrementa_num_empregados

AFTER INSERT ON empregados

FOR EACH ROW

BEGIN

    UPDATE departamentos

    SET num_empregados = num_empregados + 1

    WHERE id = NEW.departamento_id;

END;

''')

# Commit e fechar a conexão

conn.commit()

conn.close()