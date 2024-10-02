from conexao import criar_conexao

def consultar_alunos_matriculados(curso):
    conexao = criar_conexao()
    cursor = conexao.cursor()

    query_alunos_matriculados = """
        SELECT alunos.nome, cursos.nome_curso, matriculas.data_matricula
        FROM alunos
        JOIN matriculas ON alunos.id = matriculas.aluno_id
        JOIN cursos ON cursos.id = matriculas.curso_id
        WHERE cursos.nome_curso = %s
    """
    cursor.execute(query_alunos_matriculados, (curso,))
    resultados = cursor.fetchall()

    print(f"Alunos matriculados no curso {curso}:")
    for linha in resultados:
        print(f"Aluno: {linha[0]}, Curso: {linha[1]}, Data de Matrícula: {linha[2]}")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    curso = 'Cálculo'
    consultar_alunos_matriculados(curso)
