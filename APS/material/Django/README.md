# Passo 1: Criar o ambiente virtual
Isso ajuda a manter as dependências do projeto isoladas.

```bash
python -m venv venv
```

# Ativar o ambiente virtual
- No Windows:
```bash
venv\Scripts\activate
```
- No Linux/macOS:
```bash
source venv/bin/activate
```

# Passo 2: Instalar Django
O Django será instalado dentro do ambiente virtual.

```bash
pip install django
```

# Passo 3: Criar o projeto Django
Cria a estrutura principal do projeto Django.

```bash
django-admin startproject ordem_servico .
```

### Estrutura criada:
- `ordem_servico/` -> Diretório principal do projeto contendo as configurações.
  - `ordem_servico/` -> Diretório de configurações com arquivos como `settings.py`, `urls.py`, etc.
  - `manage.py` -> Arquivo usado para executar várias tarefas no projeto, como rodar o servidor.

# Passo 4: Executar o servidor pela primeira vez
Isso verificará se tudo foi configurado corretamente.

```bash
python manage.py runserver
```
O servidor estará disponível em [http://127.0.0.1:8000](http://127.0.0.1:8000).

# Passo 5: Criar o primeiro aplicativo (App) no projeto
Um app representa uma funcionalidade específica do sistema.

```bash
python manage.py startapp servicos
```

### Estrutura do app `servicos`:
- `servicos/`
  - `__init__.py` -> Indica que esse diretório é um pacote Python.
  - `admin.py` -> Arquivo onde registramos nossos modelos para serem gerenciados pelo admin do Django.
  - `apps.py` -> Configuração do aplicativo.
  - `models.py` -> Onde definimos os modelos (tabelas do banco de dados).
  - `tests.py` -> Onde escrevemos os testes para o app.
  - `views.py` -> Onde definimos as funções que lidarão com as requisições dos usuários.

# Passo 6: Registrar o app nas configurações do projeto
Para que o Django reconheça o novo app criado, é necessário registrá-lo em `settings.py`.

Abra `ordem_servico/settings.py` e adicione o app `servicos` na lista `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    ...
    'servicos',  # Registrando o app criado
]
```

# Passo 7: Definir o modelo de ordem de serviço
Agora vamos definir os dados que a ordem de serviço terá. Abra `servicos/models.py` e adicione o seguinte:

```python
from django.db import models

class OrdemDeServico(models.Model):
    cliente = models.CharField(max_length=100)  # Nome do cliente
    descricao = models.TextField()  # Descrição do serviço
    data_criacao = models.DateTimeField(auto_now_add=True)  # Data de criação da ordem
    data_conclusao = models.DateTimeField(null=True, blank=True)  # Data de conclusão do serviço
    concluido = models.BooleanField(default=False)  # Status da ordem

    def __str__(self):
        return f"{self.cliente} - {self.descricao[:20]}..."
```

# Passo 8: Fazer migrações
Crie as tabelas do banco de dados baseadas no modelo definido.

- Primeiro, gere os arquivos de migração:

```bash
python manage.py makemigrations
```

- Depois, aplique as migrações ao banco de dados:

```bash
python manage.py migrate
```

# Passo 9: Registrar o modelo no admin
Para gerenciar as ordens de serviço na interface de administração do Django, precisamos registrar o modelo. Abra `servicos/admin.py` e adicione o seguinte:

```python
from django.contrib import admin
from .models import OrdemDeServico

admin.site.register(OrdemDeServico)
```

# Passo 10: Criar um superusuário para acessar o admin
Vamos criar um superusuário para poder acessar o painel de administração.

```bash
python manage.py createsuperuser
```

Siga as instruções para definir o nome de usuário, e-mail e senha.

# Passo 11: Testar o admin do Django
Execute o servidor novamente:

```bash
python manage.py runserver
```

Acesse o admin em [http://127.0.0.1:8000/admin](http://127.0.0.1:8000/admin).

Faça login com o superusuário criado e veja se consegue gerenciar as ordens de serviço.

# Passo 12: Criar as Views para o app de serviços
Agora, vamos criar algumas views para lidar com as requisições.

Abra `servicos/views.py` e adicione o seguinte:

```python
from django.shortcuts import render
from .models import OrdemDeServico

def lista_ordens(request):
    ordens = OrdemDeServico.objects.all()  # Consulta todas as ordens de serviço
    return render(request, 'servicos/lista_ordens.html', {'ordens': ordens})
```

# Passo 13: Definir URLs para o app de serviços
Precisamos definir URLs que apontem para as views criadas.

Crie um novo arquivo `servicos/urls.py` e adicione o seguinte:

```python
from django.urls import path
from . import views

urlpatterns = [
    path('', views.lista_ordens, name='lista_ordens'),  # URL para listar as ordens de serviço
]
```

# Passo 14: Incluir URLs do app no projeto principal
Abra `ordem_servico/urls.py` e inclua as URLs do app `servicos`:

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('ordens/', include('servicos.urls')),  # Incluindo URLs do app servicos
]
```

# Passo 15: Configurar o diretório de templates local
Crie um diretório chamado `templates` dentro do diretório `servicos`.

Dentro do diretório `templates`, crie um subdiretório chamado `servicos` e coloque os templates relacionados ao app lá. O caminho do template será `servicos/templates/servicos/lista_ordens.html`.

# Passo 16: Atualizar o template HTML para listar as ordens
Atualize `servicos/views.py` para usar o caminho do template local:

```python
from django.shortcuts import render
from .models import OrdemDeServico

def lista_ordens(request):
    ordens = OrdemDeServico.objects.all()  # Consulta todas as ordens de serviço
    return render(request, 'servicos/lista_ordens.html', {'ordens': ordens})
```

Crie o template `servicos/templates/servicos/lista_ordens.html`:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Ordens de Serviço</title>
    <link rel="stylesheet" type="text/css" href="{% static 'servicos/styles.css' %}">  <!-- Incluindo o CSS -->
</head>
<body>
    <h1>Ordens de Serviço</h1>
    <ul>
        {% for ordem in ordens %}
            <li>{{ ordem.cliente }} - {{ ordem.descricao }}</li>
        {% endfor %}
    </ul>
</body>
</html>
```

# Passo 17: Adicionar CSS ao projeto
Crie um diretório chamado `static` dentro do diretório `servicos` e dentro dele, crie um arquivo chamado `styles.css`.

Crie `servicos/static/servicos/styles.css`:

```css
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

h1 {
    color: #333;
    text-align: center;
    margin-top: 20px;
}

ul {
    list-style-type: none;
    padding: 0;
}

li {
    background: #fff;
    margin: 10px;
    padding: 15px;
    border-radius: 5px;
    box-shadow: 0 0 5px rgba(0,0,0,0.1);
}
```

# Passo 18: Configurar o uso de arquivos estáticos
Abra `ordem_servico/settings.py` e adicione o seguinte:

```python
import os

STATIC_URL = '/static/'
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'servicos/static'),
]
```

# Passo 19: Testar o sistema com CSS
Execute o servidor novamente:

```bash
python manage.py runserver
```

Acesse [http://127.0.0.1:8000/ordens/](http://127.0.0.1:8000/ordens/) e veja a lista de ordens de serviço com o estilo aplicado (CSS).

# Persistência no SQLite
Por padrão, o Django utiliza o SQLite como banco de dados. O arquivo do banco de dados é criado como `db.sqlite3` na raiz do projeto. Esse arquivo contém todas as tabelas e dados do sistema de ordem de serviço, sendo suficiente para persistir os dados enquanto desenvolvemos localmente.

Para persistência em um ambiente de produção, recomenda-se usar um banco de dados mais robusto, como
