from conexao import criar_conexao

def contar_alunos_por_curso(curso_id):
    conexao = criar_conexao()
    cursor = conexao.cursor()
    cursor.callproc('contar_alunos_por_curso', [curso_id, 0])

    for resultado in cursor.stored_results():
        total_alunos = resultado.fetchone()[0]
        print(f"Total de alunos no curso com ID {curso_id}: {total_alunos}")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    curso_id = 1  # Exemplo: curso com ID 1
    contar_alunos_por_curso(curso_id)
