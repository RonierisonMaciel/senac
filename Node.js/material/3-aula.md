# Aula 3: Criando e Iniciando um Servidor com Express.js

## **Objetivo**
Nesta aula, você aprenderá:
- O que é o Express.js.
- Como instalar e configurar o Express.js.
- Como criar e iniciar um servidor básico.
- Como definir rotas simples.

---

## **Pré-requisitos**
- Node.js e NPM instalados no sistema.
- Conclusão das aulas anteriores.

---

## **Passo a Passo**

### 1. Criando o Projeto

1. **Crie uma pasta para o projeto e navegue até ela:**
   ```bash
   mkdir aula-express
   cd aula-express
   ```

2. **Inicialize o projeto Node.js:**
   ```bash
   npm init -y
   ```

3. **Instale o Express.js:**
   ```bash
   npm install express
   ```

---

### 2. Criando o Servidor Básico

1. **Crie um arquivo chamado `server.js`:**
   ```bash
   touch server.js
   ```

2. **Adicione o código para criar e iniciar o servidor:**
   ```javascript
   const express = require('express');
   const app = express();

   // Rota inicial
   app.get('/', (req, res) => {
       res.send('Bem-vindo ao servidor Express!');
   });

   // Iniciar o servidor
   const PORT = 3000;
   app.listen(PORT, () => {
       console.log(`Servidor rodando em http://localhost:${PORT}`);
   });
   ```

3. **Inicie o servidor:**
   ```bash
   node server.js
   ```

4. **Abra o navegador e acesse:**
   ```
   http://localhost:3000
   ```
   Você verá a mensagem:
   ```
   Bem-vindo ao servidor Express!
   ```

---

### 3. Criando Rotas Adicionais

1. **Adicione mais rotas ao servidor:**
   Atualize o arquivo `server.js`:
   ```javascript
   app.get('/sobre', (req, res) => {
       res.send('Esta é a página Sobre.');
   });

   app.get('/contato', (req, res) => {
       res.send('Página de Contato.');
   });
   ```

2. **Reinicie o servidor e teste as novas rotas:**
   - Para `/sobre`, acesse:
     ```
     http://localhost:3000/sobre
     ```
   - Para `/contato`, acesse:
     ```
     http://localhost:3000/contato
     ```

---

### 4. Utilizando Middleware para JSON

1. **Adicione um middleware para processar dados JSON:**
   Atualize o arquivo `server.js`:
   ```javascript
   app.use(express.json());

   app.post('/dados', (req, res) => {
       const { nome, idade } = req.body;
       res.send(`Nome: ${nome}, Idade: ${idade}`);
   });
   ```

2. **Teste a rota POST usando o Postman ou cURL:**
   - Envie uma requisição POST para `http://localhost:3000/dados` com o seguinte corpo JSON:
     ```json
     {
         "nome": "Roni",
         "idade": 22
     }
     ```

   - Resposta esperada:
     ```
     Nome: Roni, Idade: 22
     ```

---

### 5. Adicionando Scripts ao `package.json`

1. **Adicione um script para iniciar o servidor:**
   Abra o arquivo `package.json` e edite a seção `scripts`:
   ```json
   "scripts": {
       "start": "node server.js"
   }
   ```

2. **Inicie o servidor usando o comando:**
   ```bash
   npm start
   ```

---

### 6. Estruturando o Projeto

1. **Organize o projeto em pastas:**
   - Crie uma pasta para as rotas:
     ```bash
     mkdir routes
     cd routes
     ```
   - Cria o arquivo das rotas`:
      ```bash
      touch routes.js
      ```
   - Mova as rotas para um arquivo separado chamado `routes.js`:
     ```javascript
     const express = require('express');
     const router = express.Router();

     router.get('/', (req, res) => {
         res.send('Bem-vindo ao servidor Express!');
     });

     router.get('/sobre', (req, res) => {
         res.send('Esta é a página Sobre.');
     });

     router.get('/contato', (req, res) => {
         res.send('Página de Contato.');
     });

     module.exports = router;
     ```

2. **Atualize o `server.js` para usar o arquivo de rotas:**
   ```javascript
   const express = require('express');
   const app = express();
   const routes = require('./routes');

   app.use(express.json());
   app.use('/', routes);

   const PORT = 3000;
   app.listen(PORT, () => {
       console.log(`Servidor rodando em http://localhost:${PORT}`);
   });
   ```

---

## **Resumo dos Comandos**

- **Criar um novo projeto Node.js:**
  ```bash
  mkdir aula-express
  cd aula-express
  npm init -y
  ```

- **Instalar o Express.js:**
  ```bash
  npm install express
  ```

- **Criar um arquivo de servidor:**
  ```bash
  touch server.js
  ```

- **Iniciar o servidor:**
  ```bash
  node server.js
  ```

- **Iniciar o servidor com script do NPM:**
  ```bash
  npm start
  ```

---

## **Atividade Prática**

1. Crie uma rota chamada `/produtos` que retorne um array de produtos:
   ```javascript
   const produtos = [
       { id: 1, nome: 'Notebook', preco: 3000 },
       { id: 2, nome: 'Teclado', preco: 200 },
       { id: 3, nome: 'Mouse', preco: 100 }
   ];

   app.get('/produtos', (req, res) => {
       res.json(produtos);
   });
   ```

2. Teste a rota no navegador ou no Postman:
   - Acesse:
     ```
     http://localhost:3000/produtos
     ```
   - Resposta esperada (JSON):
     ```json
     [
         { "id": 1, "nome": "Notebook", "preco": 3000 },
         { "id": 2, "nome": "Teclado", "preco": 200 },
         { "id": 3, "nome": "Mouse", "preco": 100 }
     ]
     ```

---

## **Conclusão**

Parabéns! Você criou um servidor básico com o Express.js, adicionou rotas e até integrou middleware para processar dados JSON. Nas próximas aulas, iremos aprofundar em endpoints mais complexos e boas práticas para o desenvolvimento backend.
