const os = require('os');
const saudacao = require('./util');
const chalk = require('chalk');

console.log(chalk.white("Sistema Operacional:", os.platform()));
console.log(chalk.green("Release:", os.release()));
console.log(chalk.blue("Release:", os.version()));

const nome = 'Roni';
console.log(chalk.magenta(saudacao(nome)));
