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
