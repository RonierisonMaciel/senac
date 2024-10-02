from conexao import criar_conexao

def consultar_quantidade_alunos_por_curso():
    conexao = criar_conexao()
    cursor = conexao.cursor()

    query_quantidade_alunos = """
        SELECT cursos.nome_curso, COUNT(matriculas.aluno_id) AS total_alunos
        FROM cursos
        JOIN matriculas ON cursos.id = matriculas.curso_id
        GROUP BY cursos.nome_curso
        ORDER BY total_alunos DESC
    """
    cursor.execute(query_quantidade_alunos)
    resultados = cursor.fetchall()

    print("\nQuantidade de alunos por curso:")
    for linha in resultados:
        print(f"Curso: {linha[0]}, Total de Alunos: {linha[1]}")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    consultar_quantidade_alunos_por_curso()
