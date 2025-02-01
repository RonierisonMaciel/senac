const mongoose = require('mongoose');

const FilmeSchema = new mongoose.Schema({
    titulo: { type: String, required: true },
    genero: { type: String, required: true },
});

module.exports = mongoose.model('Filme', FilmeSchema);
