const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const router = express.Router();

// Conexão ao banco de dados
const db = new sqlite3.Database('./database.db', (err) => {
    if (err) {
        console.error('Erro ao conectar ao banco de dados', err.message);
    } else {
        console.log('Conectado ao banco de dados com sucesso!');
    }
});

// Criação da tabela tasks
db.run(`
    CREATE TABLE IF NOT EXISTS tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        status INTEGER NOT NULL
    )
`);

// Rota GET task
router.get('/task', (req, res) => {
    const query = 'SELECT * FROM tasks';
    db.all(query, [], (err, rows) => {
        if (err) {
            console.error('Erro ao executar a query', err.message);
            return res.status(500).json({ error: 'Ocorreu um erro ao buscar as tasks' });
        }
        res.json(rows);
    });
});

// Rota POST task
router.post('/task', (req, res) => {
    const { titulo, status } = req.body;
    const query = 'INSERT INTO tasks (titulo, status) VALUES (?, ?)';
    db.run(query, [titulo, status ? 1 : 0], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(201).json({ id: this.lastID, titulo, status });
    });
});

// Rota PUT task
router.put('/task/:id', (req, res) => {
    const { id } = req.params;
    const { titulo, status } = req.body;
    const query = 'UPDATE tasks SET titulo = ?, status = ? WHERE id = ?';
    db.run(query, [titulo, status ? 1 : 0, id], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.json({ message: 'Task atualizada com sucesso!' });
    });
});

// Rota DELETE task
router.delete('/task/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM tasks WHERE id = ?';
    db.run(query, [id], function (err) {
        if (err) {
            return res.status(500).json({ error: err.message });
        }
        res.status(204).send();
    });
});

module.exports = router;
