from pessoa import Pessoa

class Paciente(Pessoa):
    def __init__(self, nome, idade, peso, altura):
        super().__init__(nome, idade)
        self._peso = peso
        self._altura = altura

    @property
    def imc(self):
        return self._peso / self._altura ** 2
    
    def apresentar(self):
        super().apresentar()
        print(f"Meu IMC é {self.imc:.2f}")

p = Paciente("Maria", 30, 60, 1.65)
p.apresentar()
