from pessoa import Pessoa

class Funcionario(Pessoa):
    def __init__(self, nome, idade, salario):
        super().__init__(nome, idade)
        self._salario = salario

    @property
    def salario(self):
        return self._salario
    
    @salario.setter
    def salario(self, valor):
        if valor >= 0:
            self._salario = valor
        else:
            raise ValueError("Salário não pode ser negativo")
    
    def apresentar(self):
        super().apresentar()
        print(f"Meu salário é R$ {self._salario:.2f}.")

f = Funcionario("João", 20, 3000)
f.apresentar()
