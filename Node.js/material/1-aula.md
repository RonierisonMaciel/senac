# Aula 1: Introdução e Configuração do Ambiente com Node.js

## **Objetivo**
Nesta aula, você irá aprender:
- O que é Node.js.
- Como instalar e configurar o ambiente de desenvolvimento.
- Como criar e executar o primeiro script Node.js.

---

## **Pré-requisitos**
- Instale o [Node.js](https://nodejs.org).
- Um editor de código, como [VSCode](https://code.visualstudio.com).

---

## **Passo a Passo**

### 1. Verificando a instalação do Node.js
Após instalar o Node.js, verifique se ele foi instalado corretamente. Abra o terminal e digite:

```bash
node -v
```

A saída mostrará a versão do Node.js instalada, como por exemplo:

```bash
v18.17.0
```

Também verifique o gerenciador de pacotes (NPM):

```bash
npm -v
```

Saída esperada:

```bash
9.6.7
```

---

### 2. Criando o projeto Node.js

1. **Crie uma pasta para o projeto:**
   ```bash
   mkdir aula-nodejs
   cd aula-nodejs
   ```

2. **Inicialize um projeto Node.js:**
   ```bash
   npm init -y
   ```
   Isso criará um arquivo `package.json` com as configurações básicas do projeto.

---

### 3. Criando o primeiro script Node.js

1. **Crie o arquivo `index.js` na pasta do projeto:**
   ```bash
   touch index.js
   ```

2. **Adicione o seguinte código ao arquivo `index.js`:**
   ```javascript
   console.log("Hello, Node.js!");
   ```

3. **Execute o script no terminal:**
   ```bash
   node index.js
   ```

   Saída esperada:
   ```bash
   Hello, Node.js!
   ```

---

### 4. Personalizando o script

Agora vamos modificar o código para exibir uma mensagem personalizada.

1. **Atualize o arquivo `index.js`:**
   ```javascript
   const userName = "Roni";
   console.log(`Bem-vindo ao curso de Node.js, ${userName}!`);
   ```

2. **Execute novamente o script:**
   ```bash
   node index.js
   ```

   Saída esperada:
   ```bash
   Bem-vindo ao curso de Node.js, Roni!
   ```

---

## **Resumo dos Comandos**

- **Verificar versão do Node.js**:
  ```bash
  node -v
  ```
- **Verificar versão do NPM**:
  ```bash
  npm -v
  ```
- **Criar uma nova pasta**:
  ```bash
  mkdir aula-nodejs
  cd aula-nodejs
  ```
- **Inicializar um projeto Node.js**:
  ```bash
  npm init -y
  ```
- **Criar um arquivo JavaScript**:
  ```bash
  touch index.js
  ```
- **Executar um arquivo Node.js**:
  ```bash
  node index.js
  ```

---

## **Atividade Prática**

1. Modifique o script para perguntar o nome do usuário e exibir uma mensagem personalizada.
2. Exemplo:
   ```javascript
   const readline = require("readline");

   const rl = readline.createInterface({
       input: process.stdin,
       output: process.stdout,
   });

   rl.question("Qual é o seu nome? ", (name) => {
       console.log(`Bem-vindo ao curso de Node.js, ${name}!`);
       rl.close();
   });
   ```

3. **Execute novamente:**
   ```bash
   node index.js
   ```

   Interaja com o script no terminal.

---

## **Conclusão**

Parabéns! Você configurou seu ambiente, criou seu primeiro script e o executou com sucesso. Nas próximas aulas, vamos explorar mais sobre o Node.js e como criar aplicações práticas.
