const express = require('express');
const router = express.Router();

// Rota principal
router.get('/', (req, res) => {
    res.send('<h1>Minha página principal!</h1>');
});

// Rota de sobre
router.get('/sobre', (req, res) => {
    res.send('<h1>Sobre</h1><p>Este é um servidor de teste.</p><i>esse é um texto em itálico</i>');
});

module.exports = router;
