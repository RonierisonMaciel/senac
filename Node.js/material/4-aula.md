# Aula 4: Criando Endpoints Simples com CRUD

## **Objetivo**
Nesta aula, você aprenderá:
- Como criar endpoints utilizando os métodos HTTP: `GET`, `POST`, `PUT`, `DELETE`.
- Implementar um CRUD (Create, Read, Update, Delete) básico.
- Utilizar dados armazenados em memória.

---

## **Pré-requisitos**
- Node.js e Express.js instalados.
- Conclusão das aulas anteriores.

---

## **Passo a Passo**

### 1. Configurando o Projeto

1. **Crie uma pasta para o projeto e navegue até ela:**
   ```bash
   mkdir aula-crud
   cd aula-crud
   ```

2. **Inicialize o projeto Node.js:**
   ```bash
   npm init -y
   ```

3. **Instale o Express.js:**
   ```bash
   npm install express
   ```

4. **Crie um arquivo chamado `server.js`:**
   ```bash
   touch server.js
   ```

---

### 2. Configurando o Servidor e Dados em Memória

1. **Adicione o código básico ao arquivo `server.js`:**
   ```javascript
   const express = require('express');
   const app = express();

   app.use(express.json()); // Middleware para interpretar JSON

   const PORT = 3000;
   app.listen(PORT, () => {
       console.log(`Servidor rodando em http://localhost:${PORT}`);
   });
   ```

2. **Adicione os dados em memória (no mesmo arquivo):**
   ```javascript
   let tarefas = [
       { id: 1, titulo: 'Estudar Node.js', concluido: false },
       { id: 2, titulo: 'Criar API com Express', concluido: true },
   ];
   ```

---

### 3. Criando os Endpoints

#### 3.1. **GET** - Listar todas as tarefas
Adicione o seguinte código ao `server.js`:
```javascript
// Rota para listar todas as tarefas
app.get('/tarefas', (req, res) => {
    res.json(tarefas);
});
```

#### 3.2. **POST** - Criar uma nova tarefa
```javascript
// Rota para criar uma nova tarefa
app.post('/tarefas', (req, res) => {
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

#### 3.3. **PUT** - Atualizar uma tarefa
```javascript
// Rota para atualizar uma tarefa
app.put('/tarefas/:id', (req, res) => {
    const { id } = req.params;
    const { titulo, concluido } = req.body;

    const tarefa = tarefas.find(t => t.id === parseInt(id));
    if (!tarefa) {
        return res.status(404).json({ error: 'Tarefa não encontrada' });
    }

    if (titulo) tarefa.titulo = titulo;
    if (concluido !== undefined) tarefa.concluido = concluido;

    res.json(tarefa);
});
```

#### 3.4. **DELETE** - Remover uma tarefa
```javascript
// Rota para remover uma tarefa
app.delete('/tarefas/:id', (req, res) => {
    const { id } = req.params;
    const index = tarefas.findIndex(t => t.id === parseInt(id));

    if (index === -1) {
        return res.status(404).json({ error: 'Tarefa não encontrada' });
    }

    tarefas.splice(index, 1);
    res.status(204).send(); // Sem conteúdo
});
```

---

### 4. Testando os Endpoints

1. **Inicie o servidor:**
   ```bash
   node server.js
   ```

2. **Testes com ferramentas como Postman, Insomnia ou cURL:**

   #### **GET** `/tarefas`
   - Método: `GET`
   - URL: `http://localhost:3000/tarefas`
   - Resposta:
     ```json
     [
         { "id": 1, "titulo": "Estudar Node.js", "concluido": false },
         { "id": 2, "titulo": "Criar API com Express", "concluido": true }
     ]
     ```

   #### **POST** `/tarefas`
   - Método: `POST`
   - URL: `http://localhost:3000/tarefas`
   - Body (JSON):
     ```json
     {
         "titulo": "Aprender sobre métodos HTTP",
         "concluido": false
     }
     ```
   - Resposta:
     ```json
     {
         "id": 3,
         "titulo": "Aprender sobre métodos HTTP",
         "concluido": false
     }
     ```

   #### **PUT** `/tarefas/:id`
   - Método: `PUT`
   - URL: `http://localhost:3000/tarefas/1`
   - Body (JSON):
     ```json
     {
         "titulo": "Estudar Node.js Avançado",
         "concluido": true
     }
     ```
   - Resposta:
     ```json
     {
         "id": 1,
         "titulo": "Estudar Node.js Avançado",
         "concluido": true
     }
     ```

   #### **DELETE** `/tarefas/:id`
   - Método: `DELETE`
   - URL: `http://localhost:3000/tarefas/1`
   - Resposta:
     ```
     (Nenhum conteúdo - status 204)
     ```

---

### 5. Melhorando a Estrutura com Scripts no `package.json`

1. **Adicione o seguinte script no `package.json`:**
   ```json
   "scripts": {
       "start": "node server.js"
   }
   ```

2. **Inicie o servidor com o comando:**
   ```bash
   npm start
   ```

---

## **Resumo dos Comandos**

- **Criar pasta e inicializar o projeto:**
  ```bash
  mkdir aula-crud
  cd aula-crud
  npm init -y
  ```
- **Instalar o Express.js:**
  ```bash
  npm install express
  ```
- **Criar e executar o servidor:**
  ```bash
  node server.js
  ```
- **Iniciar o servidor com NPM:**
  ```bash
  npm start
  ```

---

## **Atividade Prática**

1. Adicione uma nova rota `GET /tarefas/:id` que retorna uma tarefa específica pelo seu ID.
   - Exemplo:
     ```javascript
     app.get('/tarefas/:id', (req, res) => {
         const { id } = req.params;
         const tarefa = tarefas.find(t => t.id === parseInt(id));
         if (!tarefa) {
             return res.status(404).json({ error: 'Tarefa não encontrada' });
         }
         res.json(tarefa);
     });
     ```

2. Teste a nova rota enviando requisições para IDs válidos e inválidos.

---

## **Conclusão**

Nesta aula, você aprendeu a criar um CRUD básico usando Node.js e Express. Isso incluiu criar endpoints para listar, criar, atualizar e excluir dados em memória. Nas próximas aulas, exploraremos como conectar a API a um banco de dados para persistir os dados.
