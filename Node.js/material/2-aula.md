# Aula 2: Módulos e Gerenciamento de Pacotes com NPM

## **Objetivo**
Nesta aula, você aprenderá:
- O que são módulos no Node.js e como utilizá-los.
- Como criar módulos personalizados.
- Como instalar e utilizar pacotes do NPM.

---

## **Pré-requisitos**
- Concluir a configuração do ambiente da Aula 1.
- Ter o Node.js e o NPM instalados no sistema.

---

## **Passo a Passo**

### 1. Trabalhando com Módulos no Node.js

1. **Crie um novo arquivo chamado `main.js`:**
   ```bash
   touch main.js
   ```

2. **Utilize um módulo nativo do Node.js (`os`) no arquivo `main.js`:**
   ```javascript
   const os = require('os');
   // Informações do sistema operacional
   console.log('Sistema operacional:', os.type());
   console.log('Versão do SO:', os.release());
   console.log('Arquitetura:', os.arch());
   ```

3. **Execute o arquivo para verificar as informações do sistema operacional:**
   
   ```bash
   node main.js
   ```

---

### 2. Criando Módulos Personalizados

1. **Crie um arquivo chamado `utils.js`:**
   ```bash
   touch utils.js
   ```

2. **Adicione uma função ao módulo `utils.js`:**
   ```javascript
   function saudacao(nome) {
       return `Olá, ${nome}! Bem-vindo ao Node.js!`;
   }

   module.exports = saudacao;
   ```

3. **Importe e atualize o módulo em `main.js`:**
   Atualize o arquivo `main.js`:
   ```javascript
   const os = require('os');
   const saudacao = require('./utils');

   console.log('Sistema operacional:', os.type());
   console.log('Versão do SO:', os.release());
   console.log('Arquitetura:', os.arch());

   const mensagem = saudacao('Patrícia');
   console.log(mensagem);
   ```

4. **Execute novamente o script:**
   ```bash
   node main.js
   ```

   Saída esperada:
   ```bash
   Sistema operacional: Linux
   Versão do SO: 5.15.0-50-generic
   Arquitetura: x64
   Olá, Patrícia! Bem-vindo ao Node.js!
   ```

---

### 3. Trabalhando com o Gerenciador de Pacotes NPM

1. **Instale um pacote do NPM (exemplo: `chalk`):**
   ```bash
   npm install chalk@4
   ```

2. **Verifique o `package.json` para confirmar que o pacote foi adicionado.**

3. **Use o pacote `chalk` no arquivo `main.js`:**
   Atualize o arquivo `main.js`:
   ```javascript
   const os = require('os');
   const saudacao = require('./utils');
   const chalk = require('chalk');

   console.log(chalk.blue('Sistema operacional:'), os.type());
   console.log(chalk.green('Versão do SO:'), os.release());
   console.log(chalk.yellow('Arquitetura:'), os.arch());

   const mensagem = saudacao('Roni');
   console.log(chalk.magenta(mensagem));
   ```

4. **Execute novamente o script:**
   ```bash
   node main.js
   ```

   A saída agora estará colorida com as cores definidas no código.

---

### 4. Adicionando Scripts no `package.json`

1. **Adicione o seguinte script no `package.json`:**
   Abra o `package.json` e edite a seção `scripts`:
   ```json
   "scripts": {
       "start": "node main.js"
   }
   ```

2. **Execute o script usando NPM:**
   ```bash
   npm start
   ```

   O comando acima executará o arquivo `main.js`.

---

### 5. Desinstalando Pacotes NPM

1. **Remova o pacote `chalk` para entender o processo:**
   ```bash
   npm uninstall chalk
   ```

2. **Verifique que o pacote foi removido do `package.json`.**

3. **Tente executar o arquivo novamente para observar o erro causado pela remoção do pacote:**
   ```bash
   node main.js
   ```

---

## **Resumo dos Comandos**

- **Criar um novo arquivo:**
  ```bash
  touch [nome-do-arquivo].js
  ```
- **Instalar um pacote com NPM:**
  ```bash
  npm install [nome-do-pacote]
  ```
- **Desinstalar um pacote com NPM:**
  ```bash
  npm uninstall [nome-do-pacote]
  ```
- **Rodar o projeto usando NPM:**
  ```bash
  npm start
  ```

---

## **Atividade Prática**

1. Crie um módulo chamado `math.js` que exporte duas funções:
   - `soma(a, b)` - Retorna a soma de dois números.
   - `multiplica(a, b)` - Retorna o produto de dois números.

2. Importe o módulo `math.js` em `main.js` e utilize as funções para exibir os resultados.

Exemplo do módulo `math.js`:
```javascript
function soma(a, b) {
    return ..;
    // complete o return (retorno)
}

function multiplica(a, b) {
    return ..;
    // complete o return (retorno)
}

module.exports = { soma, multiplica };
```

Exemplo de uso no `main.js`:
```javascript
const { soma, multiplica } = require('./math');

console.log('Soma:', soma(3, 5));
console.log('Multiplicação:', multiplica(4, 7));
```

---

## **Conclusão**

Parabéns! Nesta aula, você aprendeu:
- Como usar módulos nativos e criar módulos personalizados no Node.js.
- Como instalar e utilizar pacotes NPM.
- Como adicionar scripts ao `package.json` para facilitar a execução do projeto.
