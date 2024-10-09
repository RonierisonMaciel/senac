Para configurar a replicação no MySQL em servidores Windows, siga o passo a passo abaixo. No Windows, você fará ajustes no arquivo de configuração do MySQL (my.ini) e usará o MySQL Workbench ou o MySQL CLI para executar os comandos necessários.

### Passo 1: Localizar e Modificar o Arquivo `my.ini` no Windows

1. **Localize o arquivo `my.ini`**:
   - O arquivo de configuração `my.ini` no Windows geralmente está localizado no seguinte caminho:
     - `C:\ProgramData\MySQL\MySQL Server X.X\my.ini` (onde `X.X` é a versão do MySQL).

2. **Modificar o Arquivo `my.ini` no Servidor Mestre**:
   - Abra o arquivo `my.ini` em um editor de texto como **Notepad++** ou **Bloco de Notas** com privilégios de administrador.
   - Adicione ou modifique as seguintes linhas no arquivo:
     ```ini
     [mysqld]
     server-id=1            # Identificador único para o servidor mestre
     log-bin=mysql-bin       # Ativa o log binário, necessário para replicação
     ```
   - **Salve o arquivo** e **reinicie o serviço MySQL** para aplicar as mudanças:
     1. Vá até o "Gerenciador de Tarefas" e selecione a aba "Serviços".
     2. Encontre o serviço "MySQL" ou "MySQL X.X", clique com o botão direito e escolha "Reiniciar".

3. **Modificar o Arquivo `my.ini` no Servidor Escravo**:
   - No servidor escravo, abra o arquivo `my.ini` da mesma forma.
   - Adicione ou modifique as seguintes linhas no arquivo:
     ```ini
     [mysqld]
     server-id=2            # Identificador único para o servidor escravo
     relay-log=mysql-relay-bin   # Ativa o log relay, necessário para a replicação
     ```
   - **Salve o arquivo** e **reinicie o serviço MySQL** no servidor escravo, seguindo os mesmos passos anteriores.

### Passo 2: Configuração no MySQL Workbench ou CLI

1. **No Servidor Mestre**:
   - Abra o **MySQL Workbench** ou o **MySQL CLI** e conecte-se ao **servidor mestre**.
   - Crie um **usuário de replicação**:

     ```sql
     CREATE USER 'replicacao_user'@'%' IDENTIFIED BY 'senha';
     GRANT REPLICATION SLAVE ON *.* TO 'replicacao_user'@'%';
     ```

   - Verifique o **log binário e a posição atual** do mestre:

     ```sql
     SHOW MASTER STATUS;
     ```

     Isso retornará o nome do arquivo binário (`mysql-bin.000001`) e a posição (`107`, por exemplo). Você precisará dessas informações para configurar o escravo.

2. **No Servidor Escravo**:
   - Conecte-se ao **servidor escravo** no **MySQL Workbench** ou **CLI**.
   - Execute o comando para configurar o escravo, usando o nome do arquivo binário e a posição obtida no mestre:

     ```sql
     CHANGE MASTER TO
     MASTER_HOST='mestre_host',
     MASTER_USER='replicacao_user',
     MASTER_PASSWORD='senha',
     MASTER_LOG_FILE='mysql-bin.000001',
     MASTER_LOG_POS=107;
     ```

   - **Inicie o processo de replicação** no escravo:

     ```sql
     START SLAVE;

     ```
   - Verifique o status da replicação para garantir que está funcionando:

     ```sql
     SHOW SLAVE STATUS\G
     ```

### Passo 3: Testar a Replicação

Após a configuração, insira dados no **servidor mestre** e verifique se foram replicados no **servidor escravo**.

1. **Inserir dados no mestre**:

   ```sql
   INSERT INTO clientes (nome, cidade) VALUES ('Lucas', 'Curitiba');
   ```

2. **Verificar no escravo**:

   ```sql
   SELECT * FROM clientes;
   ```

Se a replicação estiver funcionando corretamente, o registro inserido no mestre deve aparecer no escravo.
