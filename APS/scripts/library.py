# Padrão Singleton aplicado à classe GerenciadorDeSalas
class GerenciadorDeSalas:
    # Atributo estático que mantém a única instância da classe
    _instance = None
    salas = []
    observadores = []

    # Método especial __new__ para implementar o padrão Singleton
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super().__new__(cls)  # Cria uma nova instância se não existir
            cls._instance.salas = ["Sala 1", "Sala 2", "Sala 3"]  # Inicializa as salas
        return cls._instance

    # Método para reservar uma sala
    def reservar_sala(self, sala):
        if sala in self.salas:
            self.salas.remove(sala)  # Remove a sala da lista de disponíveis
            print(f"Sala {sala} reservada com sucesso.")
        else:
            print(f"Sala {sala} indisponível.")

    # Método para liberar uma sala previamente reservada
    def liberar_sala(self, sala):
        self.salas.append(sala)  # Adiciona a sala de volta à lista de disponíveis
        self.notificar_observadores(sala)  # Notifica os observadores que a sala está disponível

    # Método para adicionar observadores (usuários) interessados em notificações
    def adicionar_observador(self, usuario):
        self.observadores.append(usuario)

    # Método para notificar todos os observadores (padrão Observer)
    def notificar_observadores(self, sala):
        for usuario in self.observadores:
            usuario.notificar(sala)  # Chama o método de notificação para cada observador

# Classe do usuário que deseja ser notificado quando uma sala se tornar disponível
class Usuario:
    def __init__(self, nome):
        self.nome = nome

    # Método que será chamado quando o usuário for notificado
    def notificar(self, sala):
        print(f"{self.nome}, a {sala} está disponível para reserva!")

# Exemplo de reuso de componentes com uma função simulando uma API de calendário
def verificar_disponibilidade(sala, horario):
    # Simulação de uma API de calendário que verifica a disponibilidade em horários específicos
    if horario in ["09:00", "10:00", "11:00"]:
        return False  # Horário está ocupado
    return True  # Horário está disponível

# Padrão MVC (Model-View-Controller) aplicado ao sistema de gerenciamento de salas

# Model: Classe Sala que armazena os dados da sala
class Sala:
    def __init__(self, nome, disponivel=True):
        self.nome = nome
        self.disponivel = disponivel

# View: Responsável por exibir as informações ao usuário
class SalaView:
    def exibir_sala(self, sala):
        status = "disponível" if sala.disponivel else "indisponível"
        print(f"Sala {sala.nome} está {status}")

# Controller: Controla a interação entre o Model (dados) e a View (exibição)
class SalaController:
    def __init__(self, sala, view):
        self.sala = sala
        self.view = view

    # Método para alterar o status de disponibilidade da sala e atualizar a visualização
    def alterar_status_sala(self, disponivel):
        self.sala.disponivel = disponivel
        self.view.exibir_sala(self.sala)

# Exemplo de uso completo do sistema

# Criando usuários (observadores) que desejam ser notificados quando as salas forem liberadas
usuario1 = Usuario("João")
usuario2 = Usuario("Maria")

# Criando a instância única do GerenciadorDeSalas (Singleton)
gerenciador = GerenciadorDeSalas()

# Adicionando observadores (usuários interessados em receber notificações)
gerenciador.adicionar_observador(usuario1)
gerenciador.adicionar_observador(usuario2)

# Reservando e liberando uma sala
gerenciador.reservar_sala("Sala 1")
gerenciador.liberar_sala("Sala 1")  # Notifica os observadores

# Verificando disponibilidade de uma sala em um horário específico (simulação de API externa)
horario = "10:00"
sala = "Sala 2"
disponivel = verificar_disponibilidade(sala, horario)

if disponivel:
    print(f"{sala} está disponível no horário {horario}.")
else:
    print(f"{sala} está ocupada no horário {horario}.")

# Exemplo de aplicação do padrão MVC
sala_mvc = Sala("Sala 3", disponivel=False)  # Criação da sala (Model)
view = SalaView()  # Instanciando a View para exibir a sala
controller = SalaController(sala_mvc, view)  # Controller ligando o Model à View

# Mudando o status da sala e exibindo o resultado através do padrão MVC
controller.alterar_status_sala(True)  # Altera para disponível e exibe
