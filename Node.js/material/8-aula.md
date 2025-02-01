# **Aula 8: Projeto Final - Full Stack com Node.js, React e MongoDB**

## **Objetivo**
Nesta aula, você aprenderá:
- Como criar um **back-end** com Node.js, Express.js e MongoDB.
- Como desenvolver um **front-end** em React para interagir com a API.
- Como consumir APIs com **fetch** e gerenciar o estado no React.
- Como implantar o **back-end** e **front-end** no **AWS EC2**.

---

## **Pré-requisitos**
- Conta ativa na **AWS**.
- **MongoDB Atlas** para banco de dados na nuvem.
- **Node.js e NPM** instalados no sistema.
- Conhecimento básico de **MongoDB, Express.js e React.js**.

---

# **📌 Parte 1: Criando o Back-end com Node.js e MongoDB**

## **1. Configuração Inicial do Projeto**

1. **Crie a pasta do back-end e navegue até ela:**
   ```bash
   mkdir aula-backend
   cd aula-backend
   ```

2. **Inicialize o projeto Node.js e instale as dependências:**
   ```bash
   npm init -y
   npm install express cors dotenv mongoose
   ```

3. **Crie a estrutura do projeto:**
   ```bash
   mkdir routes models
   touch server.js .env .gitignore routes/filmes.js models/Filme.js
   ```

4. **Adicione o seguinte ao `.gitignore`:**
   ```
   node_modules/
   .env
   ```

---

## **2. Configurando o Banco de Dados MongoDB**

### Criando um Cluster MongoDB no **MongoDB Atlas**
1. Acesse [MongoDB Atlas](https://www.mongodb.com/cloud/atlas).
2. Crie um **Cluster** gratuito.
3. Vá para "Database Access" e crie um **usuário** com acesso ao banco.
4. Em "Network Access", adicione **0.0.0.0/0** para permitir acesso de qualquer IP.
5. Copie a **Connection String** e substitua no `.env`.

### Defina as variáveis no `.env`:
```env
PORT=5000
MONGO_URI=mongodb+srv://SEU_USUARIO:SUA_SENHA@SEU_CLUSTER.mongodb.net/filmesDB?retryWrites=true&w=majority
```

---

## **3. Configurando o Servidor Back-end**

1. **Crie o modelo do banco de dados `models/Filme.js`:**
   ```javascript
   const mongoose = require('mongoose');

   const FilmeSchema = new mongoose.Schema({
       titulo: { type: String, required: true },
       genero: { type: String, required: true },
   });

   module.exports = mongoose.model('Filme', FilmeSchema);
   ```

2. **Configure o `server.js` para conectar ao MongoDB:**
   ```javascript
   const express = require('express');
   const cors = require('cors');
   const dotenv = require('dotenv');
   const mongoose = require('mongoose');
   const filmesRoutes = require('./routes/filmes');

   dotenv.config();
   const app = express();

   app.use(express.json());
   app.use(cors());

   mongoose.connect(process.env.MONGO_URI)
   .then(() => console.log('MongoDB Conectado'))
   .catch(err => console.error('Erro ao conectar ao MongoDB', err));

   app.use('/filmes', filmesRoutes);

   const PORT = process.env.PORT || 5000;
   app.listen(PORT, () => {
       console.log(`Servidor rodando na porta ${PORT}`);
   });
   ```

---

## **4. Criando as Rotas da API**

1. **Adicione o código no `routes/filmes.js`:**
   ```javascript
   const express = require('express');
   const Filme = require('../models/Filme');
   const router = express.Router();

   // Listar todos os filmes
   router.get('/', async (req, res) => {
       const filmes = await Filme.find();
       res.json(filmes);
   });

   // Criar um novo filme
   router.post('/', async (req, res) => {
       const { titulo, genero } = req.body;
       if (!titulo || !genero) {
           return res.status(400).json({ error: 'Título e gênero são obrigatórios.' });
       }
       const novoFilme = new Filme({ titulo, genero });
       await novoFilme.save();
       res.status(201).json(novoFilme);
   });

   // Atualizar um filme
   router.put('/:id', async (req, res) => {
       const { id } = req.params;
       const { titulo, genero } = req.body;
       const filmeAtualizado = await Filme.findByIdAndUpdate(id, { titulo, genero }, { new: true });
       if (!filmeAtualizado) return res.status(404).json({ error: 'Filme não encontrado' });
       res.json(filmeAtualizado);
   });

   // Remover um filme
   router.delete('/:id', async (req, res) => {
       const { id } = req.params;
       const filmeRemovido = await Filme.findByIdAndDelete(id);
       if (!filmeRemovido) return res.status(404).json({ error: 'Filme não encontrado' });
       res.status(204).send();
   });

   module.exports = router;
   ```

---

## **5. Rodando o Servidor**
1. **Inicie o servidor localmente:**
   ```bash
   node server.js
   ```

2. **Acesse os endpoints no navegador ou Postman:**
   - `GET` → `http://localhost:5000/filmes`
   - `POST` → `http://localhost:5000/filmes`
   - `PUT` → `http://localhost:5000/filmes/:id`
   - `DELETE` → `http://localhost:5000/filmes/:id`

---

# **📌 Parte 2: Criando o Front-end com React**

## **1. Criando o Projeto React**
1. **Crie a pasta do front-end e inicie o React:**
   ```bash
   cd ..
   npx create-react-app aula-frontend
   cd aula-frontend
   ```

2. **Instale dependências para consumir a API:**
   ```bash
   npm install axios
   ```

3. **Instale o Bootstrap:**
   ```bash
   npm install bootstrap
   ```
4. **Importar para o index.js**
   ```js
   import 'bootstrap/dist/css/bootstrap.min.css';
   ```

---

## **2. Criando a Interface no React**
1. **Edite o `src/App.js` com o código:**
   ```javascript
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
   ```

---

## **🎯 Conclusão**
Agora temos um projeto **Full Stack** com:
✅ **Back-end Node.js + MongoDB no AWS Elastic Beanstalk**  
✅ **Front-end React rodando no AWS EC2 ou Vercel**  
