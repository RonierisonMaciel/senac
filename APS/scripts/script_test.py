import re

usuarios = []

def validar_nome(nome):
    if len(nome) >= 3:
        return True
    else:
        print("Nome deve ter no mínimo 3 caracteres.")
        return False

def validar_email(email):
    padrao_email = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    if re.match(padrao_email, email):
        return True
    else:
        print("E-mail inválido.")
        return False

def validar_senha(senha):
    if len(senha) >= 6:
        return True
    else:
        print("A senha deve ter no mínimo 6 caracteres.")
        return False

def cadastrar_usuario(nome, email, senha):
    if validar_nome(nome) and validar_email(email) and validar_senha(senha):
        usuarios.append({"nome": nome, "email": email, "senha": senha})
        print(f"Usuário {nome} cadastrado com sucesso!")
    else:
        print("Erro ao cadastrar usuário. Verifique as informações.")

def exibir_usuarios():
    if usuarios:
        print("\nUsuários cadastrados:")
        for usuario in usuarios:
            print(f"Nome: {usuario['nome']}, E-mail: {usuario['email']}")
    else:
        print("Nenhum usuário cadastrado.")

while True:
    print("\nOpções: 1 - Cadastrar | 2 - Exibir Usuários | 3 - Sair")
    opcao = input("Escolha uma opção: ")

    if opcao == '1':
        nome = input("Digite seu nome: ")
        email = input("Digite seu e-mail: ")
        senha = input("Digite sua senha: ")
        cadastrar_usuario(nome, email, senha)
    elif opcao == '2':
        exibir_usuarios()
    elif opcao == '3':
        break
    else:
        print("Opção inválida. Tente novamente.")
