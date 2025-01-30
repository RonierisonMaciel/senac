const express = require('express');
const app = express();
app.use(express.json());

// Rota principal
app.get('/', (req, res) => {
    res.send('<h1>Olá, mundo!</h1>');
});

// Rota de sobre
app.get('/sobre', (req, res) => {
    res.send('<h1>Sobre</h1><p>Este é um servidor de teste.</p><i>esse é um texto em itálico</i>');
});

// Rota de contato
app.get('/contato', (req, res) => {
    res.send('<h1>Contato</h1><p>Entre em contato conosco pelo <a href="mailto:roni@gmail.com">email</a>');
});

// Rota dos dados
app.post('/dados', (req, res) => {
    const { nome, idade, email } = req.body;
    res.send(`O seu nome é ${nome} você tem ${idade} anos e seu email é ${email}`);
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`O servidor está rodando em http://localhost:${PORT}`);
});
