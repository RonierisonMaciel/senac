tarefas = []

def adicionar_tarefa():
    pass

def exibir_tarefas():
    pass

def concluir_tarefa():
    pass

while True:
    print("\nOpções: 1 - Adicionar Tarefa | 2 - Exibir Tarefas | 3 - Concluir Tarefa | 4 - Sair")
    opcao = input("Escolha uma opção: ")

    if opcao == '1':
        nome_tarefa = input("Digite o nome da tarefa: ")
        adicionar_tarefa(nome_tarefa)
    elif opcao == '2':
        exibir_tarefas()
    elif opcao == '3':
        exibir_tarefas()
        try:
            indice = int(input("Digite o número da tarefa para concluir: "))
            concluir_tarefa(indice)
        except ValueError:
            print("Entrada inválida. Digite um número.")
    elif opcao == '4':
        break
    else:
        print("Opção inválida. Tente novamente.")
