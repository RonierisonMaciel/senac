from conexao import criar_conexao

def consultar_cursos_professores():
    conexao = criar_conexao()
    cursor = conexao.cursor()

    query_cursos_professores = """
        SELECT cursos.nome_curso, professores.nome
        FROM cursos
        JOIN professores ON cursos.professor_id = professores.id
    """
    cursor.execute(query_cursos_professores)
    resultados = cursor.fetchall()

    print("\nCursos e seus respectivos professores:")
    for linha in resultados:
        print(f"Curso: {linha[0]}, Professor: {linha[1]}")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    consultar_cursos_professores()
