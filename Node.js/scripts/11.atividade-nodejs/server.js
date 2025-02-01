const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');
const mongoose = require('mongoose');

const filmesRoutes = require('./routes/filmes');
const app = express();
const port = 3000;

dotenv.config();
app.use(express.json());
app.use(cors());

mongoose.connect(process.env.MONGO_URI)
    .then(() => console.log('Conectado'))
    .catch(err => console.error('Erro ao conectar', err.message));

app.use('/filmes', filmesRoutes);

app.listen(port, () => {
    console.log(`O servidor está rodando em http://localhost:${port}`);
});
