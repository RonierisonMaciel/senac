# Termos do Python em inglês e português com exemplos de uso

## Estruturas de controle

- **if** (se): Avalia uma condição e executa um bloco de código se a condição for verdadeira.

    ```python
    if x > 10:
        print('Maior que 10')
    ```

- **else** (senão): Usado após um bloco if para executar um código se a condição if for falsa.

    ```python
    else:
        print('Não é maior que 10')
    ```

- **elif** (senão se): Combinação de else e if, permite verificar múltiplas condições.

    ```python
    elif x == 10:
        print('Igual a 10')
    ```

## Laços de repetição

- **for** (para): Itera sobre uma sequência (como uma lista, tupla ou string).

    ```python
    for i in range(5):
        print(i)
    ```

- **while** (enquanto): Executa um bloco de código enquanto a condição for verdadeira.

    ```python
    while x < 10:
        x += 1
    ```

## Controle de fluxo

- **break** (interromper): Sai do laço de repetição antes que ele termine naturalmente.

    ```python
    for i in range(10):
        if i == 5:
            break
    ```

- **continue** (continuar): Pula para a próxima iteração do laço de repetição.

    ```python
    for i in range(10):
        if i % 2 == 0:
            continue
    ```

## Funções e definições

- **def** (definir): Define uma nova função.

    ```python
    def minha_funcao():
        print('Olá, mundo!')
    ```

- **return** (retornar): Retorna um valor de uma função.

    ```python
    def soma(a, b):
        return a + b
    ```

## Classes e objetos

- **class** (classe): Define uma nova classe.

    ```python
    class MinhaClasse:
        pass
    ```

## Outros termos comuns

- **range** (intervalo): Gera uma sequência de números.

    ```python
    for i in range(1, 10):
        print(i)
    ```

- **print** (imprimir): Exibe uma mensagem na tela.

    ```python
    print('Hello, World!')
    ```

- **input** (entrada): Lê a entrada do usuário.

    ```python
    nome = input('Digite seu nome: ')
    ```

- **try** (tentar) e **except** (exceto): Tratamento de exceções.

    ```python
    try:
        x = int('a')
    except ValueError:
        print('Erro de valor')
    ```

- **finally** (finalmente): Executa um bloco de código, independentemente de um erro ocorrer ou não.

    ```python
    try:
        x = int('a')
    finally:
        print('Operação finalizada')
    ```

- **with** (com) e **as** (como): Simplifica o uso de recursos que precisam ser fechados, como arquivos.

    ```python
    with open('arquivo.txt') as f:
        conteudo = f.read()
    ```

- **lambda** (função anônima): Cria pequenas funções anônimas.

    ```python
    soma = lambda x, y: x + y
    print(soma(2, 3))
    ```

- **import** (importar) e **from** (de): Importa módulos e funções específicas de módulos.

    ```python
    import math
    print(math.sqrt(9))

    from math import sqrt
    print(sqrt(9))
    ```

- **global** (global): Declara que uma variável é global.

    ```python
    global x
    x = 10
    ```

- **nonlocal** (não local): Refere-se a variáveis de escopo não local.

    ```python
    def funcao():
        nonlocal y
        y = 10
    ```

- **assert** (afirmar): Testa uma condição e causa um erro se a condição for falsa.

    ```python
    assert x > 0, 'x deve ser positivo'
    ```

- **yield** (gerar): Pausa a função e retorna um valor, mas retém o estado da função para continuar posteriormente.

    ```python
    def contador():
        yield 1
        yield 2
    ```

- **pass** (sem operação): Um placeholder (substituto temporário) para onde o código será escrito posteriormente.

    ```python
    for _ in range(5):
        pass
    ```

- **True** (Verdadeiro) e **False** (Falso): Constantes booleanas.

    ```python
    if True:
        print('Isso é verdadeiro')
    ```

- **None** (Nenhum): Representa a ausência de valor.

    ```python
    x = None
    if x is None:
        print('x é None')
    ```
