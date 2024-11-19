# Prática

## Índice B-tree

### **Exemplo**

```sql
CREATE TABLE Produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10, 2)
) ENGINE=InnoDB;

INSERT INTO Produtos (nome, preco)
SELECT CONCAT('Produto', FLOOR(RAND() * 1000)), RAND() * 1000
FROM information_schema.tables
LIMIT 1000;

-- Consulta sem índice na coluna 'preco'
SELECT * FROM Produtos WHERE preco BETWEEN 100 AND 200;

-- Adicionar um índice B-tree na coluna 'preco'
CREATE INDEX idx_preco ON Produtos(preco);

-- Consulta com índice na coluna 'preco'
SELECT * FROM Produtos WHERE preco BETWEEN 100 AND 200;
```

### **Explicação do Índice B-tree**

- **Como funciona**: Os índices B-tree organizam os valores de forma hierárquica em uma estrutura de árvore balanceada. Isso permite que o MySQL execute buscas eficientes, especialmente para operações de intervalo (`BETWEEN`, `>`, `<`, etc.).

- **Vantagens**:
  - Excelente desempenho para operações de busca e ordenação.
  - Suporta consultas de intervalo e busca por prefixo em strings.

- **No exemplo**: O índice B-tree em `preco` permite que o MySQL localize rapidamente todos os produtos cujo preço está entre 100 e 200, sem precisar verificar cada linha da tabela.

---

## Índice Hash

### **Exemplo**

```sql
CREATE TABLE Clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100)
) ENGINE=Memory;

INSERT INTO Clientes (nome, email)
SELECT CONCAT('Cliente', FLOOR(RAND() * 359)), CONCAT('cliente', FLOOR(RAND() * 359), '@dominio.com')
FROM information_schema.tables
LIMIT 359;

-- Consulta sem índice hash
SELECT * FROM Clientes WHERE email = 'cliente45@dominio.com';

-- Adicionando índice hash na coluna 'email'
CREATE INDEX idx_email_hash ON Clientes(email) USING HASH;

-- Consulta com índice hash na coluna 'email'
SELECT * FROM Clientes WHERE email = 'cliente45@dominio.com';
```

### **Explicação do Índice Hash**

- **Como funciona**: Os índices hash utilizam uma função hash para mapear valores de chave para posições de armazenamento. São ideais para buscas de igualdade.

- **Vantagens**:
  - Muito rápidos para buscas de igualdade (`=`).

- **Desvantagens**:
  - Não suportam buscas de intervalo ou ordenação.
  - Não são úteis para operações como `LIKE 'prefix%'` ou `BETWEEN`.

- **No Exemplo**:
  - Como estamos usando uma busca por igualdade no email (`email = 'cliente45@dominio.com'`), um índice hash é apropriado.
  - **Nota Importante**: O **ENGINE=Memory** suporta índices hash. Em outros mecanismos como o InnoDB, o MySQL ignora a cláusula `USING HASH`, e o índice é criado como B-tree.
  - Portanto, este exemplo faz sentido apenas porque a tabela está usando o mecanismo de armazenamento Memory.

---

### **Resumo dos Tipos de Índices**

- **B-tree**:
  - **Suporte no MySQL**: Sim.
  - **Uso Ideal**: Buscas de igualdade, intervalos, ordenação.
  - **Exemplo**: Índice em `preco` na tabela `Produtos`.

- **Hash**:
  - **Suporte no MySQL**: Limitado ao mecanismo de armazenamento Memory.
  - **Uso Ideal**: Buscas de igualdade.
  - **Limitações**: Não suporta buscas de intervalo ou ordenação.
  - **Exemplo**: Índice hash em `email` na tabela `Clientes` usando ENGINE=Memory.

### **Recomendações**

- **Entendendo as Limitações do MySQL**:
  - É importante conhecer quais tipos de índices são suportados pelo mecanismo de armazenamento que você está usando.

### **Conclusão**

Os exemplos fornecidos ajudam a ilustrar como os índices B-tree e Hash funcionam no MySQL:

- **B-tree**: Excelente para buscas de igualdade e intervalos. Amplamente usado no MySQL com o InnoDB.
- **Hash**: Útil para buscas de igualdade, mas limitado ao ENGINE=Memory.

---
