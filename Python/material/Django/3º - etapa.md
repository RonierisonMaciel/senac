# 3º To-Do List com Django

## Objetivo

Permitir que os usuários marquem tarefas como concluídas, excluam-nas e editem seus títulos.

---

### Passo a passo

#### Parte 1: Permitir que os usuários marquem tarefas como concluídas

1. **Adicionar uma URL para concluir tarefas**:
   - No `urls.py` da aplicação `tarefas`, adicione um caminho para marcar uma tarefa como concluída:
     ```python
     from django.urls import path
     from . import views

     urlpatterns = [
         path('', views.lista_tarefas, name='lista_tarefas'),
         path('concluir/<int:id>/', views.concluir_tarefa, name='concluir_tarefa'),
     ]
     ```

2. **Criar a view para marcar como concluída**:
   - No arquivo `views.py`, crie a função `concluir_tarefa`, que altera o status da tarefa para concluída:
     ```python
     from django.shortcuts import render, redirect, get_object_or_404

     def concluir_tarefa(request, id):
         tarefa = get_object_or_404(Tarefa, id=id)
         tarefa.concluida = True
         tarefa.save()
         return redirect('lista_tarefas')
     ```

3. **Adicionar o botão de concluir no template**:
   - No arquivo `lista_tarefas.html`, adicione um botão ao lado de cada tarefa para marcar como concluída:
     ```html
     <ul>
         {% for tarefa in tarefas %}
             <li>
                 {{ tarefa.titulo }} - {% if tarefa.concluida %}Concluída{% else %}Pendente{% endif %}
                 {% if not tarefa.concluida %}
                     <a href="{% url 'concluir_tarefa' tarefa.id %}">Concluir</a>
                 {% endif %}
             </li>
         {% endfor %}
     </ul>
     ```

---

#### Parte 2: Adicionar a funcionalidade de excluir tarefas

1. **Adicionar uma URL para excluir tarefas**:
   - No `urls.py` da aplicação `tarefas`, adicione o caminho para a exclusão de uma tarefa:
     ```python
     path('excluir/<int:id>/', views.excluir_tarefa, name='excluir_tarefa'),
     ```

2. **Criar a view para excluir a tarefa**:
   - No arquivo `views.py`, adicione uma função `excluir_tarefa` para remover a tarefa:
     ```python
     def excluir_tarefa(request, id):
         tarefa = get_object_or_404(Tarefa, id=id)
         tarefa.delete()
         return redirect('lista_tarefas')
     ```

3. **Adicionar o botão de excluir no template**:
   - No arquivo `lista_tarefas.html`, adicione um botão ao lado de cada tarefa para excluir:
     ```html
     <ul>
         {% for tarefa in tarefas %}
             <li>
                 {{ tarefa.titulo }} - {% if tarefa.concluida %}Concluída{% else %}Pendente{% endif %}
                 <a href="{% url 'excluir_tarefa' tarefa.id %}">Excluir</a>
                 {% if not tarefa.concluida %}
                     <a href="{% url 'concluir_tarefa' tarefa.id %}">Concluir</a>
                 {% endif %}
             </li>
         {% endfor %}
     </ul>
     ```

---

#### Parte 3: Implementar a edição de títulos de tarefas

1. **Adicionar uma URL para editar tarefas**:
   - No `urls.py` da aplicação `tarefas`, adicione o caminho para a edição de uma tarefa:
     ```python
     path('editar/<int:id>/', views.editar_tarefa, name='editar_tarefa'),
     ```

2. **Criar a view para editar a tarefa**:
   - No arquivo `views.py`, adicione a função `editar_tarefa` para carregar a tarefa, atualizar o título e salvar as alterações:

     ```python
     from django.contrib import messages
     
     def editar_tarefa(request, id):
        tarefa = get_object_or_404(Tarefa, id=id)
        if request.method == 'POST':
            novo_titulo = request.POST.get('titulo')
            if novo_titulo:
                if Tarefa.objects.filter(titulo=novo_titulo).exists():
                    messages.error(request, 'Já existe uma tarefa com esse título.')
                    return render(request, 'editar_tarefa.html', {'tarefa': tarefa, messages: messages})

                tarefa.titulo = novo_titulo
                tarefa.save()
                return redirect('lista_tarefas')   

        return render(request, 'editar_tarefa.html', {'tarefa': tarefa})
     ```

3. **Criar o template `editar_tarefa.html`**:
   - Dentro de `templates/tarefas/`, crie um arquivo `editar_tarefa.html` para o formulário de edição:

     ```html
     <!DOCTYPE html>
     <html lang="pt-BR">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Editar Tarefa</title>
     </head>
     <body>
         <h1>Editar Tarefa</h1>
         <form method="POST">
             {% csrf_token %}
             <input type="text" name="titulo" value="{{ tarefa.titulo }}" required>
             <button type="submit">Salvar</button>
         </form>
     </body>
     </html>
     ```

4. **Adicionar o botão de editar no template `lista_tarefas.html`**:
   - Inclua o botão de editar ao lado das tarefas:

     ```html
     <a href="{% url 'editar_tarefa' tarefa.id %}">Editar</a>
     ```

---

#### Parte 4: Adicionar autenticação de usuários para listas personalizadas

1. **Adicionar URLs de autenticação padrão do django**:
   - No `urls.py` do projeto principal, inclua os URLs de autenticação:

     ```python
     from django.contrib import admin
     from django.urls import path, include

     urlpatterns = [
         path('admin/', admin.site.urls),
         path('accounts/', include('django.contrib.auth.urls')),
         path('', include('tarefas.urls')),
     ]
     ```

2. **Associar usuários às tarefas**:
   - No `models.py` da aplicação `tarefas`, adicione uma referência ao usuário:

     ```python
     from django.contrib.auth.models import User, models

     class Tarefa(models.Model):
         titulo = models.CharField(max_length=100, unique=True)
         concluida = models.BooleanField(default=False)
         usuario = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

         def __str__(self):
             return self.titulo
     ```

   - Atualize o banco de dados com as migrações:
     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```

3. **Filtrar tarefas por usuário na view `lista_tarefas`**:
   - No `views.py`, ajuste a `lista_tarefas` para exibir somente tarefas do usuário logado:
     ```python
     from django.contrib.auth.decorators import login_required

     @login_required
     def lista_tarefas(request):
         tarefas = Tarefa.objects.filter(usuario=request.user)
         return render(request, 'lista_tarefas.html', {'tarefas': tarefas})
     ```

4. **Associar o usuário ao criar uma nova tarefa**:
   - No `views.py`, atualize o código para associar o usuário ao adicionar uma tarefa:
     ```python
     if request.method == 'POST':
         titulo = request.POST.get('titulo')
         if titulo:
             Tarefa.objects.create(titulo=titulo, usuario=request.user)
             return redirect('lista_tarefas')
     ```

5. **Ajustar o template para exibir links de login e logout**:
   - No `lista_tarefas.html`, adicione links de login e logout:
     ```html
        {% if user.is_authenticated %}
        <p>Bem-vindo, {{ user.username }}! 
            <form action="{% url 'logout' %}" method="post">
                {% csrf_token %}
                <button type="submit">Sair</button>
            </form>        
        </p>
        {% else %}
        <a href="{% url 'login' %}">Entrar</a>
        {% endif %}
     ```

6. **Crie a página de login**
 - Dentro de `templates/registration/`, crie um arquivo `login.html` para o login:
    ```html
    <!DOCTYPE html>
    <html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
    </head>
    <body>
        <h2>Login</h2>
        <form method="POST">
            {% csrf_token %}
            {{ form.as_p }}
            <button type="submit">Entrar</button>
        </form>
        <a href="{% url 'password_reset' %}">Esqueci minha senha</a>
    </body>
    </html>
    ```
 - Caso ocorra algum problema com o redirecionamento para a raiz, basta colocar no `settings.py` 
    ```bash
    LOGOUT_REDIRECT_URL = '/'
   ```

7. **Criando um Superusuário**
   - Para criar um superusuário no Django, execute o seguinte comando no terminal:
     ```bash
     python manage.py createsuperuser
     ```
   - Siga as instruções na tela para definir um nome de usuário, e-mail e senha.

8. **Acessando o Admin do Django**
   - Para acessar a interface administrativa do Django, abra seu navegador e vá para o seguinte endereço: [http://127.0.0.1:8000/admin](http://127.0.0.1:8000/admin).
   - Insira suas credenciais de superusuário para fazer login.
   - Para registrar seu modelo `Tarefa` no painel administrativo, adicione o seguinte código no seu arquivo `admin.py`:
     ```python
     from django.contrib import admin
     from .models import Tarefa

     admin.site.register(Tarefa)
     ```

### Próximos passos 🚀

[👉 Continue para o próximo material!](https://github.com/RonierisonMaciel/senac/blob/main/Python/material/Django/4%C2%BA%20-%20etapa.md)
