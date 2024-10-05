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
