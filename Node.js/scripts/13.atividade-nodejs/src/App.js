import React, { useEffect, useState } from 'react';
import axios from 'axios';

const API_URL = 'http://localhost:3000/filmes';

function App() {
  const [filmes, setFilmes] = useState([]);
  const [titulo, setTitulo] = useState('');
  const [genero, setGenero] = useState('');

  useEffect(() => {
    axios.get(API_URL)
      .then((res) => setFilmes(res.data))
      .catch((err) => console.error(err));
  }, []);

  const adicionarFilme = () => {
    axios.post(API_URL, { titulo, genero })
      .then((res) => {
        setFilmes([...filmes, res.data]);
        setTitulo('');
        setGenero('');
      })
      .catch((err) => console.error(err));
  };

  const removerFilme = (id) => {
    axios.delete(`${API_URL}/${id}`)
      .then(() => setFilmes(filmes.filter((filme) => filme._id !== id)))
      .catch((err) => console.error(err));
  };

  return (
    <div className="container my-5">
      <h1 className="mb-4 text-center">Gerenciador de Filmes</h1>

      {/* Formulário de adição de filmes */}
      <div className="row g-2 mb-3">
        <div className="col-12 col-md-5">
          <input
            type="text"
            className="form-control"
            placeholder="Título"
            value={titulo}
            onChange={(e) => setTitulo(e.target.value)}
          />
        </div>
        <div className="col-12 col-md-5">
          <input
            type="text"
            className="form-control"
            placeholder="Gênero"
            value={genero}
            onChange={(e) => setGenero(e.target.value)}
          />
        </div>
        <div className="col-12 col-md-2">
          <button
            className="btn btn-primary w-100"
            onClick={adicionarFilme}
          >
            Adicionar
          </button>
        </div>
      </div>

      {/* Lista de filmes */}
      <ul className="list-group">
        {filmes.map((filme) => (
          <li
            key={filme._id}
            className="list-group-item d-flex justify-content-between align-items-center"
          >
            <span>
              <strong>{filme.titulo}</strong> - {filme.genero}
            </span>
            <button
              className="btn btn-danger btn-sm"
              onClick={() => removerFilme(filme._id)}
            >
              Remover
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;
