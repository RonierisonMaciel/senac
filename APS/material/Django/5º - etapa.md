# 5º To-Do List com Django

## Objetivo

Melhorar o design e a usabilidade da aplicação utilizando o pacote `django-bootstrap4` para integrar o Bootstrap aos templates, tornando a interface mais atraente e responsiva.

---

### Passo a passo

#### Parte 1: Instalar e configurar o `django-bootstrap4`

1. **Instalar o pacote `django-bootstrap4`**:
   - No terminal, instale o pacote usando o `pip`:
     ```bash
     pip install django-bootstrap4
     ```

2. **Adicionar `django-bootstrap4` ao `INSTALLED_APPS`**:
   - No arquivo `settings.py` do projeto, adicione `'bootstrap4'` à lista de aplicações instaladas:
     ```python
     INSTALLED_APPS = [
         'django.contrib.admin',
         'django.contrib.auth',
         'django.contrib.contenttypes',
         'django.contrib.sessions',
         'django.contrib.messages',
         'django.contrib.staticfiles',
         'bootstrap4',
         'tarefas',
     ]
     ```

#### Parte 2: Atualizar os templates para utilizar o bootstrap

1. **Carregar o template tag `bootstrap4` nos templates**:
   - No início dos templates que utilizarão o Bootstrap (por exemplo, `base.html`, `lista_tarefas.html`, `editar_tarefa.html`), carregue o template tag:
     ```django
     {% load bootstrap4 %}
     ```

2. **Atualizar o template base `base.html`**:
   - Modifique o arquivo `base.html` para incluir as referências ao CSS e JavaScript do Bootstrap usando as tags do `django-bootstrap4`:
     ```html
     {% load bootstrap4 %}
     <!DOCTYPE html>
     <html lang="pt-BR">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1">
         <title>{% block title %}To-Do List{% endblock %}</title>
         {% bootstrap_css %}
     </head>
     <body>
         <nav class="navbar navbar-expand-lg navbar-light bg-light">
             <div class="container-fluid">
                 <a class="navbar-brand" href="{% url 'lista_tarefas' %}">Minha Lista de Tarefas</a>
                 <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                     <span class="navbar-toggler-icon"></span>
                 </button>
                 <div class="collapse navbar-collapse" id="navbarSupportedContent">
                     <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                         {% if user.is_authenticated %}
                             <li class="nav-item">
                                 <span class="nav-link">Bem-vindo, {{ user.username }}!</span>
                             </li>
                             <li class="nav-item">
                                 <form action="{% url 'logout' %}" method="post" class="d-inline">
                                     {% csrf_token %}
                                     <button type="submit" class="btn btn-outline-secondary">Sair</button>
                                 </form>
                             </li>
                         {% else %}
                             <li class="nav-item">
                                 <a class="nav-link" href="{% url 'login' %}">Entrar</a>
                             </li>
                         {% endif %}
                     </ul>
                 </div>
             </div>
         </nav>

         <div class="container mt-4">
             {% if messages %}
                 {% bootstrap_messages messages %}
             {% endif %}
             {% block content %}{% endblock %}
         </div>

         {% bootstrap_javascript jquery='full' %}
     </body>
     </html>
     ```

3. **Atualizar o template `lista_tarefas.html`**:
   - Modifique o arquivo `lista_tarefas.html` para utilizar os componentes do Bootstrap:
     ```html
        {% extends 'base.html' %}
        {% load bootstrap4 %}
        {% block title %}Lista de Tarefas{% endblock %}
        {% block content %}
        <h2>Minhas Tarefas</h2>

        <form method="POST" class="row g-3 mb-4">
            {% csrf_token %}
            <div class="col-auto">
                <input type="text" name="titulo" class="form-control" placeholder="Adicione uma nova tarefa" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-primary mb-3">Adicionar</button>
            </div>
        </form>

        <ul class="list-group">
            {% for tarefa in tarefas %}
            <li
                class="list-group-item d-flex justify-content-between align-items-center {% if tarefa.concluida %}list-group-item-success{% endif %}">
                <div>
                    {% if tarefa.concluida %}
                    <s>{{ tarefa.titulo }}</s>
                    {% else %}
                    {{ tarefa.titulo }}
                    {% endif %}
                </div>
                <div>
                    {% if not tarefa.concluida %}
                    <a href="{% url 'concluir_tarefa' tarefa.id %}" class="btn btn-sm btn-success">Concluir</a>
                    {% endif %}
                    <a href="{% url 'editar_tarefa' tarefa.id %}" class="btn btn-sm btn-warning">Editar</a>
                    <button type="button" class="btn btn-sm btn-danger" data-toggle="modal"
                        data-target="#confirmModal-{{ tarefa.id }}">Excluir</button>
                </div>
            </li>
            <div class="modal fade" id="confirmModal-{{ tarefa.id }}" tabindex="-1" role="dialog"
                aria-labelledby="confirmModalLabel-{{ tarefa.id }}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="confirmModalLabel-{{ tarefa.id }}">Confirmação de Exclusão</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            Tem certeza de que deseja excluir a tarefa <strong>"{{ tarefa.titulo }}"</strong>?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <form method="POST" action="{% url 'excluir_tarefa' tarefa.id %}" style="display: inline;">
                                {% csrf_token %}
                                <button type="submit" class="btn btn-danger">Excluir</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            {% empty %}
            <li class="list-group-item">Nenhuma tarefa adicionada.</li>
            {% endfor %}
        </ul>
        {% endblock %}
     ```

4. **Atualizar o template `editar_tarefa.html`**:
   - Atualize o arquivo `editar_tarefa.html` para utilizar o Bootstrap e as tags do `django-bootstrap4`:
     ```html
     {% extends 'base.html' %}
     {% load bootstrap4 %}
     {% block title %}Editar Tarefa{% endblock %}
     {% block content %}
     <h2>Editar Tarefa</h2>
     <form method="POST">
         {% csrf_token %}
         <div class="mb-3">
             <label for="titulo" class="form-label">Título</label>
             <input type="text" name="titulo" class="form-control" id="titulo" value="{{ tarefa.titulo }}" required>
         </div>
         <button type="submit" class="btn btn-primary">Salvar</button>
         <a href="{% url 'lista_tarefas' %}" class="btn btn-secondary">Cancelar</a>
     </form>
     {% endblock %}
     ```

5. **Atualizar o template `login.html`**:
   - Modifique o arquivo `login.html` para utilizar o Bootstrap e as tags do `django-bootstrap4`:
     ```html
     {% extends 'base.html' %}
     {% load bootstrap4 %}
     {% block title %}Login{% endblock %}
     {% block content %}
     <h2>Login</h2>
     <form method="POST">
         {% csrf_token %}
         {% bootstrap_form form %}
         <button type="submit" class="btn btn-primary">Entrar</button>
     </form>
     {% endblock %}
     ```

#### Parte 3: Ajustar as views se necessário

1. **Atualizar as mensagens nas views**:
   - Utilize o framework de mensagens do Django para fornecer feedback ao usuário nas ações, se ainda não estiver utilizando:
     ```python
     from django.contrib import messages

     @login_required
     def lista_tarefas(request):
        if request.method == 'POST':
            titulo = request.POST.get('titulo')
            if titulo:
                if Tarefa.objects.filter(titulo=titulo, usuario=request.user).exists():
                    messages.error(request, 'Já existe uma tarefa com este título.')
                else:
                    try:
                        Tarefa.objects.create(titulo=titulo, usuario=request.user)
                        messages.success(request, 'Tarefa adicionada com sucesso!')
                    except IntegrityError:
                        messages.error(request, 'Erro ao salvar a tarefa. Tente novamente.')
            else:
                messages.error(request, 'O título da tarefa não pode ser vazio.')
                return redirect('lista_tarefas')
        tarefas = Tarefa.objects.filter(usuario=request.user)
        return render(request, 'lista_tarefas.html', {'tarefas': tarefas})
     ```

2. **Exibir as mensagens nos templates**:
   - Já estamos utilizando `{% bootstrap_messages messages %}` no `base.html` para exibir as mensagens com estilos do Bootstrap.

#### Parte 4: Ajustar o CSS personalizado se necessário

1. **Revisar o arquivo `estilo.css`**:
   - Verifique se há conflitos entre o CSS personalizado e o Bootstrap. Ajuste as classes ou IDs para trabalhar em conjunto com o Bootstrap.
   - Por exemplo, se você tinha estilos para botões, pode removê-los ou modificá-los para não sobrescrever o estilo padrão do Bootstrap.

#### Parte 5: Atualizar os arquivos JavaScript se necessário

1. **Ajustar o `script.js`**:
   - Caso esteja utilizando JavaScript personalizado, certifique-se de que está compatível com o Bootstrap 4.
   - Por exemplo, se você estiver utilizando componentes interativos do Bootstrap que dependem de JavaScript (como modais ou tooltips), verifique se o JavaScript está funcionando corretamente.

### Próximos passos 🚀

[👉 Continue para o próximo material!](https://github.com/Dev-UniRios/Python-Django-Course/blob/main/Django/6%C2%BA%20-%20etapa.md)
