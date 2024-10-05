from conexao import criar_conexao

def inserir_matricula(aluno_id, curso_id, data_matricula):
    conexao = criar_conexao()
    cursor = conexao.cursor()

    query_inserir_matricula = """
        INSERT INTO matriculas (aluno_id, curso_id, data_matricula) 
        VALUES (%s, %s, %s)
    """
    dados_matricula = (aluno_id, curso_id, data_matricula)
    cursor.execute(query_inserir_matricula, dados_matricula)
    conexao.commit()
    print("Nova matrícula inserida e trigger acionado.")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    inserir_matricula(1, 5, '2024-01-20')  # Exemplo: aluno_id=1, curso_id=5
