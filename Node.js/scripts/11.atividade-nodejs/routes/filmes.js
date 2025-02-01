const express = require('express');
const router = express.Router();
const Filmes = require('../models/filmes');

// Listagem de todos os filmes
router.get('/', async (req, res) => {
    const filmes = await Filmes.find();
    res.json(filmes);
});

// Cadastro de um novo filme
router.post('/', async (req, res) => {
    const { titulo, genero } = req.body;
    if (!titulo || !genero) {
        return res.status(400).json({ message: 'Título e gênero são obrigatórios' });
    }
    const novoFilme = new Filmes({ titulo, genero });
    await novoFilme.save()
    res.status(201).json(novoFilme);
});

// Atualização do filme
router.put('/:id', async (req, res) => {
    const { id } = req.params;
    const { titulo, genero } = req.body;
    const filmeAtualizado = await Filmes.findByIdAndUpdate(id, { titulo, genero }, { new: true });

    if (!filmeAtualizado) return res.status(404).json({ message: 'Filme não encontrado' });
    res.json(filmeAtualizado);
});

// Exclusão do filme
router.delete('/:id', async (req, res) => {
    const { id } = req.params;
    const filmeRemovido = await Filmes.findByIdAndDelete(id);
    if (!filmeRemovido) return res.status(404).json({ message: 'Filme não encontrado' });
    res.status(204).send();
});

module.exports = router;
