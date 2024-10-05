from dataclasses import dataclass

@dataclass
class Pessoa:
    def __init__(self, nome: str, idade: int):
        self.__nome: str = nome
        self.__idade: int = idade

    @property
    def nome(self) -> str:
        return self.__nome
    
    @property
    def nome(self) -> str:
        return self.__nome

    @property
    def idade(self):
        return self.__idade
    
    @idade.setter
    def idade(self, valor):
        if valor >= 0:
            self.__idade = valor
        else:
            raise ValueError("Idade não pode ser negativa")
        
    def apresentar(self):
        print(f"Olá, meu nome é {self.nome} e tenho {self.idade} anos.")
