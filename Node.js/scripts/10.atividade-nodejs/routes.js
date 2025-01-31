const express = require('express');
const mongoose = require('mongoose');
const router = express.Router();

// Conexão com o MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/taskDB')
    .then(() => console.log('Conectado ao MongoDB'))
    .catch((err) => console.error('Erro ao conectar ao MongoDB:', err.message));

// Definição do Schema
const taskSchema = new mongoose.Schema({
    titulo: { type: String, required: true },
    status: { type: Boolean, required: true },
});

const tasks = mongoose.model('task', taskSchema);

// Rota para listar todas as tarefas
router.get('/task', async (req, res) => {
    try {
        const task = await tasks.find();
        res.json(task);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Rota para adicionar uma tarefa
router.post('/task', async (req, res) => {
    try {
        const { titulo, status } = req.body;
        const newTask = new tasks({ titulo, status });
        await newTask.save();
        res.status(201).json(newTask);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Rota para atualizar uma tarefa
router.put('/task/:id', async (req, res) => {
    try {
        const { id } = req.params;;
        const { titulo, status } = req.body;
        const taskAtualizada = await tasks.findByIdAndUpdate(
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

// Rota para deletar uma tarefa
router.delete('/task/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const taskDeletada = await tasks.findByIdAndDelete(id);
        if (!taskDeletada) {
            return res.status(404).json({ error: 'Tarefa não encontrada' });
        }
        res.status(204).send();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
