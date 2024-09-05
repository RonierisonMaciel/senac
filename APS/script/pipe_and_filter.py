import re
from statistics import mean

# Filtro 1: Leitura de logs brutos
def read_logs(log_file):
    """
    Lê os logs de um arquivo de texto e retorna uma lista de linhas de log.
    """
    with open(log_file, 'r') as f:
        logs = f.readlines()
    print(f"Lidos {len(logs)} logs.")
    return logs

# Filtro 2: Filtragem de logs relevantes (apenas erros ou tempos de resposta acima de 1 segundo)
def filter_relevant_logs(logs):
    """
    Filtra logs para manter apenas erros ou tempos de resposta lentos (> 1 segundo).
    """
    filtered_logs = []
    for log in logs:
        if "ERROR" in log or get_response_time(log) > 1.0:
            filtered_logs.append(log)
    print(f"{len(filtered_logs)} logs filtrados como relevantes.")
    return filtered_logs

# Filtro auxiliar para extrair o tempo de resposta de um log
def get_response_time(log):
    """
    Extrai o tempo de resposta do log usando regex.
    Assumindo que o log contém a seguinte estrutura: "[data] status tempo_de_resposta URL"
    Exemplo: "[2024-09-05 10:12:33] 200 0.435 /home"
    """
    match = re.search(r'(\d+\.\d+)', log)
    if match:
        return float(match.group(1))
    return 0.0

# Filtro 3: Transformação dos logs (extração de dados importantes)
def transform_logs(logs):
    """
    Transforma os logs em um formato estruturado, extraindo o status, tempo de resposta e URL.
    """
    structured_logs = []
    for log in logs:
        # Regex para capturar os dados no formato: "[data] status tempo_de_resposta URL"
        match = re.search(r'\[(.*?)\] (\d{3}) (\d+\.\d+) (.*)', log)
        if match:
            data = {
                'timestamp': match.group(1),
                'status': int(match.group(2)),
                'response_time': float(match.group(3)),
                'url': match.group(4)
            }
            structured_logs.append(data)
    print(f"Transformados {len(structured_logs)} logs em formato estruturado.")
    return structured_logs

# Filtro 4: Cálculo de estatísticas (média de tempo de resposta e contagem de erros)
def calculate_statistics(logs):
    """
    Calcula estatísticas a partir dos logs: média de tempo de resposta e contagem de erros.
    """
    response_times = [log['response_time'] for log in logs]
    avg_response_time = mean(response_times) if response_times else 0.0

    error_logs = [log for log in logs if log['status'] >= 400]
    error_count = len(error_logs)

    print(f"Estatísticas calculadas: média de tempo de resposta = {avg_response_time:.2f}s, número de erros = {error_count}")
    return {
        'average_response_time': avg_response_time,
        'error_count': error_count
    }

# Filtro 5: Geração de relatório
def generate_report(stats):
    """
    Gera um relatório simples com as estatísticas calculadas.
    """
    report = (
        f"Relatório de Logs:\n"
        f"-----------------\n"
        f"Média de tempo de resposta: {stats['average_response_time']:.2f}s\n"
        f"Número de erros: {stats['error_count']}\n"
    )
    print("Relatório gerado:\n")
    print(report)
    return report

# Implementação do pipeline
def log_processing_pipeline(log_file):
    """
    Executa o pipeline de processamento de logs.
    """
    logs = read_logs(log_file)
    relevant_logs = filter_relevant_logs(logs)
    structured_logs = transform_logs(relevant_logs)
    stats = calculate_statistics(structured_logs)
    report = generate_report(stats)
    return report

# Executar o pipeline
if __name__ == "__main__":
    log_file = "webapp_logs.txt"  # Arquivo de logs fictício
    log_processing_pipeline(log_file)
