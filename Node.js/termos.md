# Termos do Node.js em inglês e português com exemplos de uso

## Comandos e Módulos

- **require** (requerer): Usado para importar módulos e bibliotecas.

    ```js
    const fs = require('fs');
    ```

- **module.exports** (módulo.exporta): Usado para exportar funcionalidades de um módulo.

    ```js
    module.exports = minhaFuncao;
    ```

- **exports** (exportações): Permite a exportação de variáveis ou funções de um módulo, equivalente ao **module.exports**.

    ```js
    exports.minhaFuncao = function() {
        console.log('Olá');
    };
    ```

- **process** (processo): Objeto global que fornece informações sobre o processo atual, como variáveis de ambiente, argumento da linha de comando, etc.

    ```js
    console.log(process.env);
    ```

## Gerenciamento de Pacotes

- **npm** (Node Package Manager): Gerenciador de pacotes do Node.js, usado para instalar e gerenciar dependências.

    ```bash
    npm install express
    ```

- **package.json** (arquivo de pacotes): Arquivo que contém informações sobre o projeto, como dependências, scripts e configurações do projeto.

    ```json
    {
        "name": "meu-app",
        "version": "1.0.0",
        "dependencies": {
            "express": "^4.17.1"
        }
    }
    ```

## Manipulação de Arquivos

- **fs** (file system): Módulo que fornece funcionalidades para trabalhar com o sistema de arquivos, como leitura e escrita de arquivos.

    ```js
    const fs = require('fs');
    fs.readFile('arquivo.txt', 'utf8', (err, data) => {
        if (err) throw err;
        console.log(data);
    });
    ```

- **path** (caminho): Módulo que fornece utilitários para trabalhar com caminhos de arquivos e diretórios.

    ```js
    const path = require('path');
    console.log(path.join(__dirname, 'diretorio', 'arquivo.txt'));
    ```

## Servidores e APIs

- **http** (http): Módulo nativo que permite criar servidores HTTP simples.

    ```js
    const http = require('http');
    const server = http.createServer((req, res) => {
        res.write('Olá, Mundo!');
        res.end();
    });
    server.listen(3000, () => {
        console.log('Servidor rodando na porta 3000');
    });
    ```

- **express** (express): Framework minimalista e flexível para criação de APIs e servidores HTTP.

    ```js
    const express = require('express');
    const app = express();
    
    app.get('/', (req, res) => {
        res.send('Olá, Mundo!');
    });
    
    app.listen(3000, () => {
        console.log('Servidor rodando na porta 3000');
    });
    ```

## Asincronia e Promessas

- **callback** (função de retorno): Função passada como argumento para outra função, que será chamada quando a operação assíncrona for concluída.

    ```js
    fs.readFile('arquivo.txt', 'utf8', (err, data) => {
        if (err) throw err;
        console.log(data);
    });
    ```

- **Promise** (promessa): Objeto que representa a eventual conclusão ou falha de uma operação assíncrona.

    ```js
    let p = new Promise((resolve, reject) => {
        let sucesso = true;
        if (sucesso) {
            resolve('Operação bem-sucedida');
        } else {
            reject('Falha na operação');
        }
    });
    
    p.then((resultado) => {
        console.log(resultado);
    }).catch((erro) => {
        console.log(erro);
    });
    ```

- **async** (assíncrono) e **await** (aguardar): Usados juntos para trabalhar com funções assíncronas de forma mais legível.

    ```js
    async function lerArquivo() {
        const dados = await fs.promises.readFile('arquivo.txt', 'utf8');
        console.log(dados);
    }
    
    lerArquivo();
    ```

## Manipulação de Eventos

- **EventEmitter** (emissor de eventos): Classe que permite criar e manipular eventos personalizados.

    ```js
    const EventEmitter = require('events');
    const emitter = new EventEmitter();
    
    emitter.on('evento', () => {
        console.log('Evento foi emitido!');
    });
    
    emitter.emit('evento');
    ```

## Depuração

- **console.log** (registrar): Imprime informações no console, útil para depuração.

    ```js
    console.log('Mensagem de depuração');
    ```

- **debugger** (depurador): Interrompe a execução do código para permitir a depuração interativa.

    ```js
    debugger;
    ```

## Gerenciamento de Erros

- **try** (tentar) e **catch** (pegar): Blocos para tratar exceções.

    ```js
    try {
        let resultado = minhaFuncao();
    } catch (erro) {
        console.log('Erro ocorrido:', erro);
    }
    ```

- **throw** (lançar): Lança um erro explicitamente.

    ```js
    throw new Error('Algo deu errado');
    ```

## Outros termos comuns

- **setTimeout** (temporizador): Define um atraso para a execução de um código.

    ```js
    setTimeout(() => {
        console.log('Este código será executado após 2 segundos');
    }, 2000);
    ```

- **setInterval** (intervalo): Executa um código em intervalos regulares.

    ```js
    setInterval(() => {
        console.log('Executando a cada 3 segundos');
    }, 3000);
    ```

- **clearTimeout** (limpar temporizador) e **clearInterval** (limpar intervalo): Usados para cancelar temporizadores e intervalos.

    ```js
    const timer = setTimeout(() => {
        console.log('Este código não será executado');
    }, 5000);
    clearTimeout(timer);
    ```

- **Buffer** (buffer): Classe usada para manipular dados binários.

    ```js
    const buffer = Buffer.from('Hello World', 'utf8');
    console.log(buffer);
    ```

- **global** (global): Objeto global no Node.js, semelhante ao **window** no navegador.

    ```js
    global.minhaVariavel = 10;
    console.log(minhaVariavel);
    ```

- **__dirname** (diretório atual): Variável que contém o caminho do diretório onde o arquivo está sendo executado.

    ```js
    console.log(__dirname);
    ```

- **__filename** (nome do arquivo): Variável que contém o caminho absoluto do arquivo atualmente em execução.

    ```js
    console.log(__filename);
    ```
