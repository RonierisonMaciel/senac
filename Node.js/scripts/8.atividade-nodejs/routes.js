const express = require('express');
const router = express.Router();
let task = [];

const validadeTarefa = (req, res, next) => {
    const { titulo } = req.body;
    if (!titulo || typeof titulo !== 'string') {
        return res.status(400).json({ error: 'O campo [titulo] é obrigatório e deve ser uma string' });
    }
    next(); // vai para o próximo middleware ou rota
}

router.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] ${req.method} ${req.url}`);
    next(); // vai para o próximo middleware ou rota
});

router.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Ocorreu um erro no servidor!' });
});

router.post('/task', validadeTarefa, (req, res) => {
    const { titulo, status } = req.body;

    const newTask = {
        id: task.lenght + 1,
        titulo,
        status: status || false,
    }

    task.push(newTask);
    res.status(201).json(newTask);
});

module.exports = router;
