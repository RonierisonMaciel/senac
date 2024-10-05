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
