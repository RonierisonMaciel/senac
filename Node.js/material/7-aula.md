# Aula 7: Conectando Node.js a um Banco de Dados (SQLite ou MongoDB)

## **Objetivo**
Nesta aula, você aprenderá:
- Como conectar o Node.js a um banco de dados.
- Como usar SQLite ou MongoDB para persistir dados.
- Como implementar um CRUD (Create, Read, Update, Delete) completo com um banco de dados.

---

## **Pré-requisitos**
- Node.js instalado.
- Express.js instalado no projeto.
- Conclusão das aulas anteriores.

---

## **Passo a Passo**

### 1. Configuração Inicial do Projeto

1. **Crie uma nova pasta para o projeto e navegue até ela:**
   ```bash
   mkdir aula-banco-dados
   cd aula-banco-dados
   ```

2. **Inicialize o projeto Node.js:**
   ```bash
   npm init -y
   ```

3. **Instale as dependências necessárias:**
   Para SQLite:
   ```bash
   npm install express sqlite3
   ```

   Para MongoDB:
   ```bash
   npm install express mongoose
   ```

4. **Crie o arquivo principal do servidor:**
   ```bash
   touch server.js
   ```

---

### 2. Usando SQLite

#### 2.1. **Configuração Básica**

Adicione o seguinte código ao `server.js` para configurar o SQLite:
```javascript
const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const app = express();

app.use(express.json());

// Conectar ao banco SQLite
const db = new sqlite3.Database('./database.db', (err) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados:', err.message);
    } else {
        console.log('Conectado ao banco SQLite.');
    }
});

// Criar a tabela de task, se não existir
db.run(`
    CREATE TABLE IF NOT EXISTS task (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        status INTEGER NOT NULL
    )
`);
```

---

#### 2.2. **Implementando o CRUD com SQLite**

1. **GET** - Listar todas as tarefas:
```javascript
app.get('/task', (req, res) => {
    const query = 'SELECT * FROM task';
    db.all(query, [], (err, rows) => {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json(rows);
    });
});
```

2. **POST** - Criar uma nova tarefa:
```javascript
app.post('/task', (req, res) => {
    const { titulo, status } = req.body;
    const query = 'INSERT INTO task (titulo, status) VALUES (?, ?)';
    db.run(query, [titulo, status ? 1 : 0], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(201).json({ id: this.lastID, titulo, status });
    });
});
```

3. **PUT** - Atualizar uma task:
```javascript
app.put('/task/:id', (req, res) => {
    const { id } = req.params;
    const { titulo, status } = req.body;
    const query = 'UPDATE task SET titulo = ?, status = ? WHERE id = ?';
    db.run(query, [titulo, status ? 1 : 0, id], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json({ message: 'Tarefa atualizada com sucesso' });
    });
});
```

4. **DELETE** - Remover uma tarefa:
```javascript
app.delete('/task/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM task WHERE id = ?';
    db.run(query, [id], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(204).send();
    });
});
```

---

### 3. Usando MongoDB

#### 3.1. **Configuração Básica**

Adicione o seguinte código ao `server.js` para configurar o MongoDB:
```javascript
const express = require('express');
const mongoose = require('mongoose');
const app = express();

app.use(express.json());

// Conectar ao MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/taskDB')
    .then(() => console.log('Conectado ao MongoDB'))
    .catch((err) => console.error('Erro ao conectar ao MongoDB:', err.message));

// Definir o modelo de tarefa
const taskSchema = new mongoose.Schema({
    titulo: { type: String, required: true },
    status: { type: Boolean, required: true },
});

const Tarefa = mongoose.model('Tarefa', taskSchema);
```

---

#### 3.2. **Implementando o CRUD com MongoDB**

1. **GET** - Listar todas as tarefas:
```javascript
app.get('/task', async (req, res) => {
    try {
        const tasks = await Tarefa.find();
        res.json(tasks);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

2. **POST** - Criar uma nova tarefa:
```javascript
app.post('/task', async (req, res) => {
    try {
        const { titulo, status } = req.body;
        const newTask = new Tarefa({ titulo, status });
        await newTask.save();
        res.status(201).json(newTask);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

3. **PUT** - Atualizar uma tarefa:
```javascript
app.put('/task/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const { titulo, status } = req.body;
        const taskAtualizada = await Tarefa.findByIdAndUpdate(
            id,
            { titulo, status },
            { new: true }
        );
        if (!taskAtualizada) {
            return res.status(404).json({ error: 'Tarefa não encontrada' });
        }
        res.json(taskAtualizada);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});
```

4. **DELETE** - Remover uma tarefa:
```javascript
app.delete('/task/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const taskRemovida = await Tarefa.findByIdAndDelete(id);
        if (!taskRemovida) {
            return res.status(404).json({ error: 'Tarefa não encontrada' });
        }
        res.status(204).send();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
```

---

### 4. Iniciando o Servidor

1. **Inicie o servidor SQLite:**
   ```bash
   node server.js
   ```

2. **Inicie o servidor MongoDB (certifique-se de que o MongoDB está em execução):**
   ```bash
   node server.js
   ```

---

## **Resumo dos Comandos**

- **Iniciar um projeto Node.js:**
  ```bash
  npm init -y
  ```

- **Instalar dependências:**
  - Para SQLite:
    ```bash
    npm install express sqlite3
    ```
  - Para MongoDB:
    ```bash
    npm install express mongoose
    ```

- **Iniciar o servidor:**
  ```bash
  node server.js
  ```

---

## **Conclusão**

Nesta aula, você aprendeu:
- Conectar o Node.js a um banco de dados (SQLite ou MongoDB)
- Implementar um CRUD persistente e integrar o banco ao Express.js.
- Agora você pode armazenar e manipular dados de maneira persistente!
