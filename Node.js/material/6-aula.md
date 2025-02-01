# Aula 6: Middlewares e Tratamento de Erros no Express.js

## **Objetivo**
Nesta aula, você aprenderá:
- O que são Middlewares no Express.js.
- Como criar e usar Middlewares personalizados.
- Como implementar um middleware global de tratamento de erros.
- Como aplicar middlewares para validação de dados em rotas.

---

## **Pré-requisitos**
- Node.js instalado.
- Projeto inicial configurado com Express.js.
- Conclusão das aulas anteriores.

---

## **Passo a Passo**

### 1. Configuração Inicial

1. **Crie uma nova pasta para o projeto e navegue até ela:**
   ```bash
   mkdir aula-middlewares
   cd aula-middlewares
   ```

2. **Inicialize o projeto Node.js:**
   ```bash
   npm init -y
   ```

3. **Instale o Express.js:**
   ```bash
   npm install express
   ```

4. **Crie o arquivo principal do servidor:**
   ```bash
   touch server.js
   ```

---

### 2. Criando o Servidor Básico

Adicione o seguinte código ao `server.js`:
```javascript
const express = require('express');
const app = express();

app.use(express.json()); // Middleware para interpretar JSON

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
```

---

### 3. Criando e Utilizando Middlewares

#### 3.1. Middleware de Registro de Requisições (Logger)

Adicione um middleware para registrar informações de cada requisição:
```javascript
// Middleware de logger
app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next(); // Passa para o próximo middleware ou rota
});
```

---

#### 3.2. Middleware para Validar Dados

Adicione um middleware que valide os dados enviados para a rota `POST /task`:
```javascript
// Middleware de validação
const validarTarefa = (req, res, next) => {
    const { titulo } = req.body;
    if (!titulo || typeof titulo !== 'string') {
        return res.status(400).json({ error: 'Título é obrigatório e deve ser uma string.' });
    }
    next(); // Passa para o próximo middleware ou rota
};
```

Adicione a rota `POST /task` utilizando o middleware de validação:
```javascript
let tarefas = [];

// Rota para criar uma nova tarefa
app.post('/task', validarTarefa, (req, res) => {
    const { titulo, concluido } = req.body;
    const novaTarefa = {
        id: tarefas.length + 1,
        titulo,
        concluido: concluido || false,
    };
    tarefas.push(novaTarefa);
    res.status(201).json(novaTarefa);
});
```

---

#### 3.3. Middleware Global de Tratamento de Erros

Adicione um middleware para capturar e tratar erros de forma global:
```javascript
// Middleware global de tratamento de erros
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Ocorreu um erro interno no servidor.' });
});
```

---

### 4. Testando o Servidor

1. **Inicie o servidor:**
   ```bash
   node server.js
   ```

2. **Teste os endpoints:**

   - **POST /tarefas** (sem título):
     Método: `POST`  
     URL: `http://localhost:3000/task`  
     Corpo (JSON):
     ```json
     {
         "concluido": false
     }
     ```
     Resposta esperada:
     ```json
     {
         "error": "Título é obrigatório e deve ser uma string."
     }
     ```

   - **POST /tarefas** (com título válido):
     Método: `POST`  
     URL: `http://localhost:3000/task`  
     Corpo (JSON):
     ```json
     {
         "titulo": "Estudar middlewares",
         "concluido": true
     }
     ```
     Resposta esperada:
     ```json
     {
         "id": 1,
         "titulo": "Estudar middlewares",
         "concluido": true
     }
     ```

---

### 5. Melhorando a Estrutura com Rotas Separadas

1. **Crie uma pasta `routes` e um arquivo `task.js`:**
   ```bash
   mkdir routes
   touch routes/task.js
   ```

2. **Adicione o seguinte código ao `routes/task.js`:**
   ```javascript
   const express = require('express');
   const router = express.Router();

   let tarefas = [];

   // Middleware de validação
   const validarTarefa = (req, res, next) => {
       const { titulo } = req.body;
       if (!titulo || typeof titulo !== 'string') {
           return res.status(400).json({ error: 'Título é obrigatório e deve ser uma string.' });
       }
       next();
   };

   // Rota para criar uma nova tarefa
   router.post('/', validarTarefa, (req, res) => {
       const { titulo, concluido } = req.body;
       const novaTarefa = {
           id: tarefas.length + 1,
           titulo,
           concluido: concluido || false,
       };
       tarefas.push(novaTarefa);
       res.status(201).json(novaTarefa);
   });

   module.exports = router;
   ```

3. **Atualize o `server.js` para usar o arquivo de rotas:**
   ```javascript
   const express = require('express');
   const tarefasRoutes = require('./routes/task');
   const app = express();

   app.use(express.json());
   app.use('/tarefas', tarefasRoutes);

   const PORT = 3000;
   app.listen(PORT, () => {
       console.log(`Servidor rodando em http://localhost:${PORT}`);
   });
   ```

---

## **Resumo dos Comandos**

- **Criar pasta e inicializar o projeto:**
  ```bash
  mkdir aula-middlewares
  cd aula-middlewares
  npm init -y
  ```
- **Instalar o Express.js:**
  ```bash
  npm install express
  ```
- **Criar o arquivo principal do servidor:**
  ```bash
  touch server.js
  ```
- **Iniciar o servidor:**
  ```bash
  node server.js
  ```

---

## **Atividade Prática**

1. **Adicione uma nova rota `GET /task` para listar todas as tarefas:**
   - Código:
     ```javascript
     router.get('/', (req, res) => {
         res.json(tarefas);
     });
     ```

2. **Adicione um middleware para limitar o tamanho do campo `titulo` a no máximo 50 caracteres.**

   - Middleware:
     ```javascript
     const limitarTitulo = (req, res, next) => {
         const { titulo } = req.body;
         if (titulo && titulo.length > 50) {
             return res.status(400).json({ error: 'Título deve ter no máximo 50 caracteres.' });
         }
         next();
     };
     ```

   - Use o middleware na rota `POST /task`.

---

## **Conclusão**

Nesta aula, você aprendeu:
- O conceito de Middlewares no Express.js.
- Como usar middlewares para validação e registro de requisições.
- Como implementar um middleware global de tratamento de erros.
- Como estruturar seu projeto utilizando rotas separadas.
