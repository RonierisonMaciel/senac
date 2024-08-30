# Termos de banco de dados em inglês e português com exemplos de uso

## Estruturas e comandos básicos

- **Database** (Banco de Dados): Uma coleção organizada de dados armazenados e acessíveis eletronicamente.
  
  ```sql
  CREATE DATABASE meu_banco_de_dados;
  ```

- **Table** (Tabela): Uma estrutura dentro de um banco de dados que organiza os dados em linhas e colunas.
  
  ```sql
  CREATE TABLE usuarios (
      id INT PRIMARY KEY,
      nome VARCHAR(100),
      email VARCHAR(100)
  );
  ```

- **Column** (Coluna): Um campo de dados em uma tabela, que representa um atributo do dado.
  
  ```sql
  ALTER TABLE usuarios ADD COLUMN data_nascimento DATE;
  ```

- **Row** (Linha): Uma entrada em uma tabela, que representa um conjunto completo de dados de um item.
  
  ```sql
  INSERT INTO usuarios (id, nome, email) VALUES (1, 'João', 'joao@example.com');
  ```

## Manipulação de dados

- **INSERT** (Inserir): Comando usado para adicionar novos dados a uma tabela.
  
  ```sql
  INSERT INTO produtos (nome, preco) VALUES ('Caneta', 1.50);
  ```

- **SELECT** (Selecionar): Comando para consultar dados de uma tabela.
  
  ```sql
  SELECT nome, email FROM usuarios;
  ```

- **UPDATE** (Atualizar): Comando para modificar os dados existentes em uma tabela.
  
  ```sql
  UPDATE usuarios SET email = 'joao_novo@example.com' WHERE id = 1;
  ```

- **DELETE** (Deletar): Comando para remover dados de uma tabela.
  
  ```sql
  DELETE FROM usuarios WHERE id = 1;
  ```

## Consultas e filtragem

- **WHERE** (Onde): Filtro que especifica quais registros devem ser selecionados ou manipulados.
  
  ```sql
  SELECT * FROM usuarios WHERE nome = 'João';
  ```

- **ORDER BY** (Ordenar por): Usado para ordenar os resultados de uma consulta em ordem crescente ou decrescente.
  
  ```sql
  SELECT * FROM usuarios ORDER BY nome ASC;
  ```

- **GROUP BY** (Agrupar por): Agrupa linhas que têm os mesmos valores em colunas especificadas.
  
  ```sql
  SELECT cidade, COUNT(*) FROM usuarios GROUP BY cidade;
  ```

- **HAVING** (Tendo): Usado para filtrar grupos de registros após o uso do GROUP BY.
  
  ```sql
  SELECT cidade, COUNT(*) FROM usuarios GROUP BY cidade HAVING COUNT(*) > 1;
  ```

## Funções de agregação

- **COUNT** (Contar): Retorna o número de linhas que correspondem a um critério específico.
  
  ```sql
  SELECT COUNT(*) FROM usuarios;
  ```

- **SUM** (Somar): Retorna a soma de uma coluna numérica.
  
  ```sql
  SELECT SUM(preco) FROM produtos;
  ```

- **AVG** (Média): Retorna a média de uma coluna numérica.
  
  ```sql
  SELECT AVG(preco) FROM produtos;
  ```

- **MAX** (Máximo): Retorna o valor máximo de uma coluna.
  
  ```sql
  SELECT MAX(preco) FROM produtos;
  ```

- **MIN** (Mínimo): Retorna o valor mínimo de uma coluna.
  
  ```sql
  SELECT MIN(preco) FROM produtos;
  ```

## Chaves e restrições

- **Primary Key** (Chave Primária): Uma coluna ou grupo de colunas que identificam de forma única cada linha em uma tabela.
  
  ```sql
  CREATE TABLE produtos (
      id INT PRIMARY KEY,
      nome VARCHAR(100),
      preco DECIMAL(10, 2)
  );
  ```

- **Foreign Key** (Chave Estrangeira): Uma coluna ou conjunto de colunas em uma tabela que estabelece um link entre os dados em duas tabelas.
  
  ```sql
  CREATE TABLE pedidos (
      id INT PRIMARY KEY,
      usuario_id INT,
      FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
  );
  ```

- **Unique** (Único): Restringe o valor de uma coluna para ser único em uma tabela.
  
  ```sql
  CREATE TABLE emails (
      id INT PRIMARY KEY,
      email VARCHAR(100) UNIQUE
  );
  ```

- **Index** (Índice): Melhora a velocidade das operações de consulta no banco de dados.
  
  ```sql
  CREATE INDEX idx_nome ON usuarios (nome);
  ```

## Controle de transações

- **Transaction** (Transação): Um conjunto de operações que são executadas como uma única unidade de trabalho.
  
  ```sql
  BEGIN;
  UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
  UPDATE contas SET saldo = saldo + 100 WHERE id = 2;
  COMMIT;
  ```

- **COMMIT** (Confirmar): Finaliza uma transação, salvando as alterações no banco de dados.
  
  ```sql
  COMMIT;
  ```

- **ROLLBACK** (Reverter): Desfaz as alterações feitas na transação corrente.
  
  ```sql
  ROLLBACK;
  ```

- **SAVEPOINT** (Ponto de Salvamento): Define um ponto em uma transação que pode ser revertido posteriormente.
  
  ```sql
  SAVEPOINT meu_ponto;
  ```

- **RELEASE** (Liberar): Remove um ponto de salvamento, liberando os recursos associados a ele.
  
  ```sql
  RELEASE SAVEPOINT meu_ponto;
  ```

## Outros conceitos importantes

- **View** (Visão): Uma tabela virtual baseada no resultado de uma consulta.
  
  ```sql
  CREATE VIEW usuarios_ativos AS SELECT * FROM usuarios WHERE status = 'ativo';
  ```

- **Stored Procedure** (Procedimento Armazenado): Um conjunto de instruções SQL que podem ser armazenadas e executadas no servidor de banco de dados.
  
  ```sql
  CREATE PROCEDURE aumentar_salario(IN porcentagem INT)
  BEGIN
      UPDATE funcionarios SET salario = salario + (salario * porcentagem / 100);
  END;
  ```

- **Trigger** (Gatilho): Um conjunto de instruções SQL que são automaticamente executadas (ou "disparadas") em resposta a certos eventos em uma tabela.
  
  ```sql
  CREATE TRIGGER atualiza_data_modificacao
  BEFORE UPDATE ON usuarios
  FOR EACH ROW
  SET NEW.data_modificacao = NOW();
  ```

- **Schema** (Esquema): A estrutura lógica que define a organização de tabelas, visões, índices, etc., em um banco de dados.
  
  ```sql
  CREATE SCHEMA meu_esquema;
  ```

- **Backup** (Cópia de Segurança): Uma cópia dos dados para prevenção de perda de dados.
  
  ```sql
  BACKUP DATABASE meu_banco_de_dados TO DISK = 'caminho/do/backup.bak';
  ```

- **Restore** (Restaurar): Processo de recuperação de dados de um backup.
  
  ```sql
  RESTORE DATABASE meu_banco_de_dados FROM DISK = 'caminho/do/backup.bak';
  ```
