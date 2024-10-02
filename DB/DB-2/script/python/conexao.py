# pip install mysql-connector-python
import mysql.connector

def criar_conexao():
    conexao = mysql.connector.connect(
        host="localhost",  # host do seu servidor MySQL
        user="root",  #  usuário do MySQL
        password="senha",  # senha do MySQL
        database="banco"  # nome do banco de dados
    )
    return conexao

"""
Sequência de execução dos scripts:
1. c_cursos_professores.py
2. c_alunos_matriculados.py
3. c_quantidade_alunos.py
4. c_logs.py
5. c_view_matriculas.py
6. inserir_matricula.py
7. stored_procedure.py
"""
