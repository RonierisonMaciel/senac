from conexao import criar_conexao

def consultar_logs():
    conexao = criar_conexao()
    cursor = conexao.cursor()

    query_logs = "SELECT * FROM log_matriculas"
    cursor.execute(query_logs)
    logs = cursor.fetchall()

    print("\nLog de matrículas (gerado pelo Trigger):")
    for log in logs:
        print(f"Log ID: {log[0]}, Aluno ID: {log[1]}, Curso ID: {log[2]}, Data da Ação: {log[3]}")

    cursor.close()
    conexao.close()

if __name__ == "__main__":
    consultar_logs()
