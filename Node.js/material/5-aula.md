# Aula 5: Trabalhando com Arquivos no Node.js

## **Objetivo**
Nesta aula, você aprenderá:
- Como usar o módulo `fs` (File System) para ler e gravar arquivos.
- Como armazenar dados em arquivos JSON.
- Como criar um CRUD persistente que utiliza arquivos em vez de memória.

---

## **Pré-requisitos**
- Concluir as aulas anteriores.
- Ter o Node.js e o NPM instalados.

---

## **Passo a Passo**

### 1. Configuração Inicial do Projeto

1. **Crie uma nova pasta para o projeto e navegue até ela:**
   ```bash
   mkdir aula-crud-arquivos
   cd aula-crud-arquivos
   ```

2. **Inicialize o projeto com um arquivo `package.json`:**
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

5. **Crie um arquivo `task.json` para armazenar os dados:**
   ```bash
   touch tarefas.json
   ```

6. **Inicialize o `task.json` com um array vazio:**
   ```json
   []
   ```

---

### 2. Criando o Servidor com CRUD Persistente

#### 2.1. **Configuração Básica do Servidor**

Adicione o seguinte código ao `server.js`:
```javascript
const express = require('express');
const fs = require('fs');
const app = express();

app.use(express.json());

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
```

---

#### 2.2. **Funções Auxiliares para Manipular Arquivos**

Adicione funções para manipular o arquivo `task.json`:
```javascript
const lerTarefas = () => {
    const data = fs.readFileSync('./task.json', 'utf-8');
    return JSON.parse(data);
};

const salvarTarefas = (tarefas) => {
    fs.writeFileSync('./task.json', JSON.stringify(tarefas, null, 2));
};
```

---

#### 2.3. **Implementando o CRUD**

1. **GET** - Listar todas as tarefas:
```javascript
app.get('/task', (req, res) => {
    const tarefas = lerTarefas();
    res.json(tarefas);
});
```

2. **POST** - Criar uma nova tarefa:
```javascript
app.post('/task', (req, res) => {
    const { titulo, status } = req.body;
    const tarefas = lerTarefas();

    const novaTarefa = {
        id: tarefas.length + 1,
        titulo,
        status: status || false,
    };

    tarefas.push(novaTarefa);
    salvarTarefas(tarefas);

    res.status(201).json(novaTarefa);
});
```

3. **PUT** - Atualizar uma tarefa existente:
```javascript
app.put('/task/:id', (req, res) => {
    const { id } = req.params;
    const { titulo, status } = req.body;
    const tarefas = lerTarefas();

    const tarefa = tarefas.find(t => t.id === parseInt(id));
    if (!tarefa) {
        return res.status(404).json({ error: 'Tarefa não encontrada' });
    }

    if (titulo) tarefa.titulo = titulo;
    if (status !== undefined) tarefa.status = status;

    salvarTarefas(tarefas);
    res.json(tarefa);
});
```

4. **DELETE** - Remover uma tarefa:
```javascript
app.delete('/task/:id', (req, res) => {
    const { id } = req.params;
    const tarefas = lerTarefas();

    const index = tarefas.findIndex(t => t.id === parseInt(id));
    if (index === -1) {
        return res.status(404).json({ error: 'Tarefa não encontrada' });
    }

    tarefas.splice(index, 1);
    salvarTarefas(tarefas);

    res.status(204).send();
});
```

---

### 3. Testando os Endpoints

1. **Inicie o servidor:**
   ```bash
   node server.js
   ```

2. **Teste os endpoints com ferramentas como Postman, Insomnia ou cURL:**

   #### **GET** `/task`
   - Método: `GET`
   - URL: `http://localhost:3000/task`
   - Resposta inicial:
     ```json
     []
     ```

   #### **POST** `/task`
   - Método: `POST`
   - URL: `http://localhost:3000/task`
   - Corpo (JSON):
     ```json
     {
         "titulo": "Estudar Node.js",
         "concluido": false
     }
     ```
   - Resposta esperada:
     ```json
     {
         "id": 1,
         "titulo": "Estudar Node.js",
         "concluido": false
     }
     ```

   #### **PUT** `/task/:id`
   - Método: `PUT`
   - URL: `http://localhost:3000/task/1`
   - Corpo (JSON):
     ```json
     {
         "titulo": "Estudar Node.js Avançado",
         "concluido": true
     }
     ```
   - Resposta esperada:
     ```json
     {
         "id": 1,
         "titulo": "Estudar Node.js Avançado",
         "concluido": true
     }
     ```

   #### **DELETE** `/task/:id`
   - Método: `DELETE`
   - URL: `http://localhost:3000/task/1`
   - Resposta esperada:
     ```
     (Nenhum conteúdo - Status 204)
     ```

---

### 4. Melhorando o Projeto com Scripts

1. **Adicione um script ao `package.json` para facilitar a execução:**
   No arquivo `package.json`, edite a seção `scripts`:
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

## **Resumo dos Comandos**

- **Criar pasta e inicializar o projeto:**
  ```bash
  mkdir aula-crud-arquivos
  cd aula-crud-arquivos
  npm init -y
  ```

- **Instalar o Express.js:**
  ```bash
  npm install express
  ```

- **Criar e iniciar o servidor:**
  ```bash
  node server.js
  ```

- **Iniciar o servidor com script do NPM:**
  ```bash
  npm start
  ```

---

## **Atividade Prática**

1. **Adicione uma rota `GET /task/:id` para retornar uma tarefa específica pelo ID.**
   Exemplo:
   ```javascript
   app.get('/task/:id', (req, res) => {
       const { id } = req.params;
       const tarefas = lerTarefas();

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

Parabéns! Nesta aula, você aprendeu a usar:
- Módulo `fs` para criar uma API com persistência de dados em arquivos. 
- Este é um passo importante para entender como trabalhar com dados em aplicações Node.js.
