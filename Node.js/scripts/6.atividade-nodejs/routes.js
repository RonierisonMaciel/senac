const express = require('express');
const router = express.Router();

let task = [
    { id: 1, titulo: 'Estudar Node.js', status: true },
    { id: 2, titulo: 'Estudar AWS', status: false },
];

// Rota GET task
router.get('/task', (req, res) => {
    res.json(task);
});

// Rota POST task:id
router.post('/task', (req, res) => {
    const { titulo, status } = req.body;
    const newTask = {
        id: task.length + 1,
        titulo,
        status: status || false,
    };
    task.push(newTask);
    res.status(201).json(newTask);
});

// Rota PUT task:id
router.put('/task/:id', (req, res) => {
    const { id } = req.params;
    const { titulo, status } = req.body;
    const tasks = task.find(t => t.id === parseInt(id));

    if (!tasks) {
        return res.status(404).json({ error: 'Task não encontrada' });
    }

    if (titulo) tasks.titulo = titulo;
    if (status !== undefined) tasks.status = status;

    res.json(tasks);
});

// Rota DELETE task:id
router.delete('/task/:id', (req, res) => {
    const { id } = req.params;
    const index = task.findIndex(t => t.id === parseInt(id));

    if (index === -1) {
        return res.status(404).json({ error: 'Task não encontrada' });
    }

    task.splice(index, 1);
    res.status(204).send();
});

module.exports = router;
