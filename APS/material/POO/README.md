# Orientação a Objetos (OO)

## Introdução à Orientação a Objetos (OO)

- Breve revisão sobre o que é OO, seus benefícios e por que é importante no desenvolvimento de software moderno.
- Introdução rápida aos quatro pilares: **Abstração**, **Herança**, **Polimorfismo** e **Encapsulamento**.

### Estrutura dos arquivos

```txt
projeto_pagamento/
│
├── controller/
│   └── pagamento_controller.py
│
├── model/
│   └── pagamento.py
│
└── view/
    └── pagamento_view.py
```

### 1. **Abstração**

**Explicação:**

- A abstração é o processo de ocultar detalhes de implementação complexos, expondo apenas a funcionalidade essencial de um objeto.
- O conceito é aplicado na criação de classes com métodos que representam ações de alto nível, mantendo a complexidade interna oculta.

**Exemplo prático:**
Trabalharemos com o exemplo de uma API de pagamento. Imagine que você está criando um sistema de pagamento online que suporta várias formas de pagamento (Cartão de Crédito, PayPal, PIX).

**Onde está aplicada:**

- **Classe Abstrata `Pagamento` em `model/pagamento.py`**

```python
from abc import ABC, abstractmethod

# Classe abstrata de Pagamento (Abstração)
class Pagamento(ABC):
    @abstractmethod
    def pagar(self, valor):
        pass
```

**Explicação:**

- A **abstração** é utilizada ao definir a classe abstrata `Pagamento`, que serve como um modelo genérico para diferentes tipos de pagamentos.
- Ela especifica o método `pagar`, que todas as subclasses devem implementar, sem fornecer detalhes de implementação.
- Isso permite que as subclasses se concentrem em suas próprias implementações, mantendo uma interface comum.

### 2. **Herança**

**Explicação:**

- A herança permite que uma classe (subclasse) herde atributos e métodos de outra classe (superclasse), facilitando o reuso de código.
- Explicaremos o conceito com exemplos práticos, como a criação de diferentes tipos de usuários (admin, gerente, cliente) que compartilham atributos e métodos comuns.

**Onde está aplicada:**

- **Classes `PagamentoCartaoCredito`, `PagamentoPayPal` e `PagamentoPIX` em `model/pagamento.py`**

```python
# Classe de pagamento via Cartão de Crédito (Herança de Pagamento)
class PagamentoCartaoCredito(Pagamento):
    def pagar(self, valor):
        print(f"Pagando {valor} com Cartão de Crédito")

# Classe de pagamento via PayPal (Herança de Pagamento)
class PagamentoPayPal(Pagamento):
    def pagar(self, valor):
        print(f"Pagando {valor} com PayPal")

# Classe de pagamento via PIX (Herança de Pagamento)
class PagamentoPIX(Pagamento):
    def pagar(self, valor):
        print(f"Pagando {valor} com PIX")
```

**Explicação:**

- As classes concretas **herdam** da classe abstrata `Pagamento`.
- Elas reutilizam a interface definida na classe base e fornecem suas próprias implementações do método `pagar`.
- Isso promove o reuso de código e facilita a organização hierárquica das classes.

### 3. **Polimorfismo**

**Explicação:**

- O polimorfismo permite que o mesmo método se comporte de maneiras diferentes, dependendo do objeto que o chama.

**Onde está aplicada:**

- **Uso polimórfico no Controller em `controller/pagamento_controller.py`**

```python
def processar_pagamento(self):
    # ...
    metodo.pagar(valor)  # Uso polimórfico do método pagar
    self.view.mostrar_resultado(metodo_pagamento, valor)
```

**Explicação:**

- O **polimorfismo** é demonstrado quando o método `pagar` é chamado no objeto `metodo`, sem que o tipo específico do método precise ser conhecido.
- Independentemente do tipo de pagamento (Cartão de Crédito, PayPal ou PIX), o método `pagar` é chamado da mesma maneira.
- Isso torna o código mais flexível e extensível, facilitando a adição de novos métodos de pagamento no futuro.

### 4. **Encapsulamento**

**Explicação:**

- O encapsulamento é o conceito de restringir o acesso direto a alguns componentes de um objeto e permitir a manipulação desses componentes apenas por meio de métodos públicos definidos.
- Mostraremos como isso ajuda a manter a integridade dos dados e evita que o código externo à classe modifique seus valores diretamente.

**Onde está aplicada:**

- **Atributos e métodos encapsulados nas classes em `model/pagamento.py`**

```python
class PagamentoCartaoCredito(Pagamento):
    def __init__(self):
        self.__taxa = 0.02  # Atributo privado (Encapsulamento)

    def pagar(self, valor):
        total = valor + (valor * self.__taxa)
        print(f"Pagando {total} com Cartão de Crédito (incluindo taxa de {self.__taxa * 100}%)")
```

**Explicação:**

- O atributo `__taxa` é definido como privado usando dois sublinhados `__`, impedindo o acesso direto a partir de fora da classe.
- Esse é um exemplo de **encapsulamento**, pois os detalhes internos da classe são ocultados, protegendo a integridade dos dados.
- Os métodos públicos fornecem uma interface controlada para interagir com a classe sem expor sua implementação interna.

### Estrutura Completa com Anotações

#### **`model/pagamento.py`**

```python
from abc import ABC, abstractmethod

# Classe abstrata de Pagamento (Abstração)
class Pagamento(ABC):
    @abstractmethod
    def pagar(self, valor):
        pass

# Classe de pagamento via Cartão de Crédito (Herança e Encapsulamento)
class PagamentoCartaoCredito(Pagamento):
    def __init__(self):
        self.__taxa = 0.02  # Atributo privado (Encapsulamento)

    def pagar(self, valor):
        total = valor + (valor * self.__taxa)
        print(f"Pagando {total} com Cartão de Crédito (incluindo taxa de {self.__taxa * 100}%)")

# Classe de pagamento via PayPal (Herança e Encapsulamento)
class PagamentoPayPal(Pagamento):
    def __init__(self):
        self.__taxa = 0.03  # Atributo privado (Encapsulamento)

    def pagar(self, valor):
        total = valor + (valor * self.__taxa)
        print(f"Pagando {total} com PayPal (incluindo taxa de {self.__taxa * 100}%)")

# Classe de pagamento via PIX (Herança)
class PagamentoPIX(Pagamento):
    def pagar(self, valor):
        print(f"Pagando {valor} com PIX (sem taxas)")
```

#### **`view/pagamento_view.py`**

```python
# Classe para exibir as interações com o usuário
class PagamentoView:
    def mostrar_resultado(self, metodo, valor):
        print(f"Pagamento de {valor} realizado com {metodo}.")

    def mostrar_opcoes_pagamento(self):
        print("Escolha o método de pagamento:")
        print("1. Cartão de Crédito")
        print("2. PayPal")
        print("3. PIX")

    def solicitar_valor(self):
        try:
            return float(input("Digite o valor a ser pago: "))
        except ValueError:
            print("Entrada inválida. Digite um valor numérico.")
            return self.solicitar_valor()  # Recursão para solicitar um valor válido
```

#### **`controller/pagamento_controller.py`**

```python
from model.pagamento import PagamentoCartaoCredito, PagamentoPayPal, PagamentoPIX
from view.pagamento_view import PagamentoView

class PagamentoController:
    def __init__(self):
        self.view = PagamentoView()

    def processar_pagamento(self):
        self.view.mostrar_opcoes_pagamento()
        escolha = input("Digite a opção desejada: ")

        valor = self.view.solicitar_valor()

        if escolha == "1":
            metodo = PagamentoCartaoCredito()  # Instância da classe concreta
            metodo_pagamento = "Cartão de crédito"
        elif escolha == "2":
            metodo = PagamentoPayPal()  # Instância da classe concreta
            metodo_pagamento = "PayPal"
        elif escolha == "3":
            metodo = PagamentoPIX()  # Instância da classe concreta
            metodo_pagamento = "PIX"
        else:
            print("Opção inválida")
            return

        metodo.pagar(valor)  # Chamado polimórfico
        self.view.mostrar_resultado(metodo_pagamento, valor)
```

#### **`main.py`**

```python
from controller.pagamento_controller import PagamentoController

def main():
    controller = PagamentoController()
    controller.processar_pagamento()

if __name__ == "__main__":
    main()
```

### Resumo dos conceitos aplicados

- **Abstração**:
  - A classe `Pagamento` define uma interface genérica para métodos de pagamento.
  - Oculta os detalhes de implementação, expondo apenas

 o necessário para as subclasses.

- **Herança**:
  - As classes `PagamentoCartaoCredito`, `PagamentoPayPal` e `PagamentoPIX` herdam de `Pagamento`.
  - Permite reutilizar a estrutura e garantir que todas as subclasses implementem o método `pagar`.

- **Polimorfismo**:
  - O método `pagar` é chamado da mesma forma para diferentes objetos de pagamento.
  - O controller não precisa saber o tipo específico de pagamento para executar o método.

- **Encapsulamento**:
  - Atributos como `__taxa` são privados, protegendo os dados internos das classes.
  - Métodos públicos controlam o acesso e manipulação desses dados.

### Como isso se relaciona com o dia a dia de um desenvolvedor?

- **Manutenibilidade**:
  - Separar o código em módulos e utilizar os conceitos de OO facilita a manutenção e evolução do software.
  - Novos métodos de pagamento podem ser adicionados sem alterar o fluxo principal do programa.

- **Escalabilidade**:
  - A estrutura permite que o sistema seja escalado com novas funcionalidades de forma organizada.

- **Reuso de código**:
  - A herança e a abstração promovem o reuso, evitando duplicação de código.

- **Segurança**:
  - O encapsulamento protege dados sensíveis, como taxas e informações de pagamento.

### Dicas

- **Entender o fluxo**:
  - Analise como os dados fluem do Controller para o Model e a View, e vice-versa.
  - Observe como cada componente tem uma responsabilidade específica.

- **Experimentar**:
  - Modifique o código para adicionar um novo método de pagamento, como Boleto Bancário.
  - Tente acessar um atributo privado diretamente e observe o que acontece.

- **Praticar o Polimorfismo**:
  - Adicione funcionalidades extras às subclasses e veja como o polimorfismo permite utilizá-las de forma flexível.

- **Aplicar em projetos pessoais**:
  - Utilize essa estrutura para criar outros sistemas, como gerenciamento de usuários ou sistemas de pedidos.

### Exercício prático

**Desafio**:

- Implemente um novo método de pagamento chamado `PagamentoCripto`, que permite pagamentos em criptomoedas.
- Defina uma taxa variável baseada na criptomoeda escolhida (por exemplo, Bitcoin ou Ethereum).
- Garanta que todas as práticas de abstração, herança, polimorfismo e encapsulamento sejam aplicadas.

**Objetivo**:

- Consolidar o entendimento dos conceitos apresentados.
- Aplicar os conhecimentos em um cenário próximo ao mercado atual de tecnologia.
