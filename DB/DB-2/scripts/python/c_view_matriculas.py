from conexao import criar_conexao

def consultar_view_matriculas():
    conexao = criar_conexao()
    cursor = conexao.cursor()

    query_view_matriculas = "SELECT * FROM view_matriculas_detalhadas"
    cursor.execute(query_view_matriculas)
    resultados = cursor.fetchall()

    print("\nDetalhes das matrículas (View):")
    for linha in resultados:
        print(f"Aluno: {linha[0]}, Curso: {linha[1]}, Professor: {linha[2]}, Data de Matrícula: {linha[3]}")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    consultar_view_matriculas()
