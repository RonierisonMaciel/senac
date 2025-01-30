const express = require('express');
const router = express.Router();
const fs = require('fs');

const lerTask = () => {
    const data = fs.readFileSync('./task.json', 'utf-8');
    return JSON.parse(data);
};

const salvarTask = (tasks) => {
    fs.writeFileSync('./task.json', JSON.stringify(tasks, null, 2));
};

// Rota GET task
router.get('/task', (req, res) => {
    const tasks = lerTask();
    res.json(tasks);
});

// Rota POST task
router.post('/task', (req, res) => {
    const { titulo, status } = req.body;
    const tasks = lerTask();

    const newTask = {
        id: tasks.length + 1,
        titulo,
        status: status || false,
    };
    tasks.push(newTask);
    salvarTask(tasks);

    res.status(201).json(newTask);
});

// Tarefa para casa: Implementar as rotas PUT e DELETE

module.exports = router;
