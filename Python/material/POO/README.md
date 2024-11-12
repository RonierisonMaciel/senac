# Programação Orientada a Objetos (POO) com Python

#### 1. **Arquivo:** `01_classe_objeto.py`
   - **Conteúdo:** Introdução a Classes e Objetos
   - **Código:**
     ```python
     # Definindo a classe Carro
     class Carro:
         def __init__(self, marca, modelo, ano):
             self.marca = marca
             self.modelo = modelo
             self.ano = ano

         def ligar(self):
             print(f"O {self.modelo} está ligado.")

         def acelerar(self):
             print(f"O {self.modelo} está acelerando.")

     # Criando um objeto da classe Carro
     carro1 = Carro("Toyota", "Corolla", 2021)
     carro1.ligar()
     carro1.acelerar()
     ```

   - **Explicação:** O código apresenta a definição de uma classe `Carro`, com atributos e métodos básicos. O `__init__` inicializa os atributos, enquanto `ligar` e `acelerar` são métodos que representam ações de um carro.

---

#### 2. **Arquivo:** `02_atributos_metodos.py`
   - **Conteúdo:** Explicação de Atributos e Métodos
   - **Código:**
     ```python
     class ContaBancaria:
         def __init__(self, titular, saldo=0):
             self.titular = titular
             self.saldo = saldo

         def depositar(self, valor):
             self.saldo += valor
             print(f"Depositados R${valor}. Saldo atual: R${self.saldo}")

         def sacar(self, valor):
             if self.saldo >= valor:
                 self.saldo -= valor
                 print(f"Saque de R${valor} realizado. Saldo atual: R${self.saldo}")
             else:
                 print("Saldo insuficiente.")

     conta1 = ContaBancaria("João", 500)
     conta1.depositar(200)
     conta1.sacar(150)
     ```
   - **Explicação:** A classe `ContaBancaria` demonstra o uso de métodos para depositar e sacar dinheiro, além de um atributo de saldo inicializado pelo método `__init__`.

---

#### 3. **Arquivo:** `03_encapsulamento.py`
   - **Conteúdo:** Encapsulamento
   - **Código:**
     ```python
     class ContaBancaria:
         def __init__(self, titular, saldo=0):
             self.titular = titular
             self.__saldo = saldo  # Atributo privado

         def depositar(self, valor):
             self.__saldo += valor

         def sacar(self, valor):
             if self.__saldo >= valor:
                 self.__saldo -= valor
                 print(f"Saque de R${valor} realizado.")
             else:
                 print("Saldo insuficiente.")

         def consultar_saldo(self):
             return self.__saldo

     conta1 = ContaBancaria("Maria", 500)
     conta1.depositar(300)
     print(f"Saldo atual: R${conta1.consultar_saldo()}")
     ```
   - **Explicação:** O atributo `__saldo` é privado, protegendo-o contra acesso direto de fora da classe. Ele é acessível apenas através do método `consultar_saldo`.

---

#### 4. **Arquivo:** `04_heranca.py`
   - **Conteúdo:** Herança
   - **Código:**
     ```python
     class ContaBancaria:
         def __init__(self, titular, saldo=0):
             self.titular = titular
             self.__saldo = saldo

         def depositar(self, valor):
             self.__saldo += valor

         def sacar(self, valor):
             if self.__saldo >= valor:
                 self.__saldo -= valor
                 print(f"Saque de R${valor} realizado.")
             else:
                 print("Saldo insuficiente.")

         def consultar_saldo(self):
             return self.__saldo

     class ContaCorrente(ContaBancaria):
         def __init__(self, titular, saldo=0, limite=1000):
             super().__init__(titular, saldo)
             self.limite = limite

         def sacar(self, valor):
             if self.consultar_saldo() + self.limite >= valor:
                 super().sacar(valor)
             else:
                 print("Saldo e limite insuficientes.")

     conta2 = ContaCorrente("Ana", 200)
     conta2.sacar(100)
     conta2.sacar(500)
     ```
   - **Explicação:** `ContaCorrente` herda de `ContaBancaria` e redefine o método `sacar`, permitindo o uso de um limite extra para saques.

---

#### 5. **Arquivo:** `05_polimorfismo.py`
   - **Conteúdo:** Polimorfismo
   - **Código:**
     ```python
     class Animal:
         def fazer_som(self):
             pass

     class Cachorro(Animal):
         def fazer_som(self):
             print("O cachorro late.")

     class Gato(Animal):
         def fazer_som(self):
             print("O gato mia.")

     def fazer_barulho(animal):
         animal.fazer_som()

     cachorro = Cachorro()
     gato = Gato()

     fazer_barulho(cachorro)
     fazer_barulho(gato)
     ```
   - **Explicação:** `fazer_barulho` aceita qualquer objeto do tipo `Animal`, e o método correto é chamado com base na classe do objeto passado. Isso exemplifica o polimorfismo.

---

#### 6. **Arquivo:** `06_abstracao.py`
   - **Conteúdo:** Abstração com Classes e Métodos Abstratos
   - **Código:**
     ```python
     from abc import ABC, abstractmethod

     class MeioDeTransporte(ABC):
         @abstractmethod
         def mover(self):
             pass

     class Carro(MeioDeTransporte):
         def mover(self):
             print("O carro está se movendo.")

     class Bicicleta(MeioDeTransporte):
         def mover(self):
             print("A bicicleta está se movendo.")

     def iniciar_movimento(transporte):
         transporte.mover()

     carro = Carro()
     bicicleta = Bicicleta()

     iniciar_movimento(carro)
     iniciar_movimento(bicicleta)
     ```
   - **Explicação:** Usamos a classe abstrata `MeioDeTransporte`, que força suas subclasses a implementar o método `mover`. Isso assegura que `Carro` e `Bicicleta` possuam implementações próprias de `mover`.
