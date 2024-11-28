# 4º To-Do List com Django

## Objetivo

Organizar os arquivos estáticos (CSS, JavaScript e imagens) da aplicação e melhorar o design dos templates, aplicando estilos personalizados. Além disso, refinar os modelos (`models`) se necessário.

---

### Passo a passo

#### Parte 1: Organizar os arquivos estáticos

1. **Criar a estrutura de diretórios para arquivos estáticos**

   - Dentro da aplicação `tarefas`, crie uma pasta chamada `static`.
   - Dentro da pasta `static`, crie subpastas para `css`, `js` e `images`:

     ```text
     tarefas/
     ├── static/
             ├── css/
             ├── js/
             └── images/
     ```

   - A estrutura completa deve ser:

     ```text
     tarefas/
     ├── static/
     │       ├── css/
     │       ├── js/
     │       └── images/
     ```

2. **Adicionar arquivos CSS**

   - Crie um arquivo `style.css` dentro de `tarefas/static/css/`.
   - Adicione estilos personalizados para melhorar o visual da aplicação. Por exemplo:

     ```css
     body {
         font-family: Arial, sans-serif;
         background-color: #f5f5f5;
         margin: 0;
         padding: 0;
     }

     header, footer {
         background-color: #333;
         color: #fff;
         padding: 10px 0;
         text-align: center;
     }

     h1 {
         color: #333;
     }

     .container {
         width: 80%;
         margin: auto;
         overflow: hidden;
     }

     .tarefa-concluida {
         text-decoration: line-through;
         color: gray;
     }

     .form-adicionar-tarefa {
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #fff;
        padding: 10px 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
        width: 70%;
        max-width: 600px;
     }

     .form-adicionar-tarefa input[type="text"] {
        flex: 1;
        padding: 10px;
        margin-right: 10px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 14px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
     }

     .form-adicionar-tarefa button {
        padding: 10px 15px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 14px;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease;
     }

     .form-adicionar-tarefa button:hover {
        background-color: #0056b3;
     }

     .lista-tarefas {
        list-style: none;
        padding: 0;
        margin: 0;
        max-width: 800px;
        margin: 20px auto;
     }

     .lista-tarefas li {
        background: #fff;
        margin-bottom: 10px;
        padding: 15px 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
     }

     .lista-tarefas li:hover {
        transform: translateY(-3px);
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
     }

     .lista-tarefas li a {
        margin-left: 10px;
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
        transition: color 0.3s ease;
     }

     .lista-tarefas li a:hover {
        color: #0056b3;
        text-decoration: underline;
     }

     .lista-tarefas li span {
        font-size: 16px;
        font-weight: 500;
        color: #333;
        flex: 1;
        word-break: break-word;
     }

     .form-editar-tarefa {
        display: flex;
        flex-direction: column;
        width: 50%;
        margin: 20px auto;
        background-color: #fff;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
     }

     .form-editar-tarefa input[type="text"] {
        width: 96%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 16px;
     }

     .form-editar-tarefa button {
        padding: 10px 15px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 16px;
        align-self: flex-start;
     }

     .form-editar-tarefa button:hover {
        background-color: #0056b3;
     }

     .form-editar-tarefa a {
        text-decoration: none;
        color: #007BFF;
        font-size: 14px;
        margin-top: 10px;
        align-self: flex-start;
     }

     .form-editar-tarefa a:hover {
        text-decoration: underline;
     }
     ```

3. **Adicionar arquivos JavaScript**

   - Crie um arquivo `script.js` dentro de `tarefas/static/js/`.
   - Adicione scripts JavaScript para melhorar a interatividade da aplicação. Por exemplo, você pode adicionar uma confirmação antes de excluir uma tarefa:

     ```javascript
     function confirmarExclusao() {
         return confirm('Você tem certeza que deseja excluir esta tarefa?');
     }
     ```

4. **Adicionar imagens**

   - Coloque quaisquer imagens necessárias dentro de `tarefas/static/images/`.
   - Por exemplo, você pode adicionar um logotipo para a aplicação.

#### Parte 2: Carregar e usar arquivos estáticos nos templates

1. **Configurar o `settings.py` para arquivos estáticos**

   - Certifique-se de que as configurações de arquivos estáticos estão corretas no `settings.py`:

     ```python
     import os

     STATIC_URL = '/static/'
     
     STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
     ```

2. **Referenciar arquivos estáticos nos templates**

   - Crie um arquivo `base.html` no template e inclua os arquivos CSS e JS:

     ```html
     <!DOCTYPE html>
        <html lang="pt-BR">
        <head>
            {% load static %}
            <meta charset="UTF-8">
            <title>{% block title %}To-Do List{% endblock %}</title>
            <link rel="stylesheet" href="{% static 'css/style.css' %}">
        </head>
        <body>
            <header>
                <div class="container">
                    <h1><a href="{% url 'lista_tarefas' %}" style="color: #fff; text-decoration: none;">Minha Lista de Tarefas</a></h1>
                </div>
            </header>
            <div class="container">
                {% if messages %}
                <ul class="messages">
                    {% for message in messages %}
                    <li class="{{ message.tags }}">{{ message }}</li>
                    {% endfor %}
                </ul>
                {% endif %}
                {% block content %}{% endblock %}
            </div>

            <footer>
                <p>&copy; 2024 Aplicação de lista de tarefas</p>
            </footer>

            <script src="{% static 'js/script.js' %}"></script>
        </body>

        </html>
     ```

3. **Atualizar os templates para usar classes e IDs do CSS**

   - No `lista_tarefas.html`, adicione classes ou IDs aos elementos para aplicar os estilos definidos:

     ```html
     {% extends 'base.html' %}
     {% block title %}Lista de Tarefas{% endblock %}
     {% block content %}
     <div class="conteudo">
         {% if user.is_authenticated %}
             <p>Bem-vindo, {{ user.username }}!
                 <form action="{% url 'logout' %}" method="post" style="display:inline;">
                     {% csrf_token %}
                     <button type="submit">Sair</button>
                 </form>
             </p>
         {% else %}
             <a href="{% url 'login' %}">Entrar</a>
         {% endif %}

         <form method="POST" class="form-adicionar-tarefa">
             {% csrf_token %}
             <input type="text" name="titulo" placeholder="Adicione uma nova tarefa" required>
             <button type="submit">Adicionar</button>
         </form>

         <ul class="lista-tarefas">
             {% for tarefa in tarefas %}
                 <li class="{% if tarefa.concluida %}tarefa-concluida{% endif %}">
                     {{ tarefa.titulo }}
                     <div class="acoes">
                         {% if not tarefa.concluida %}
                             <a href="{% url 'concluir_tarefa' tarefa.id %}">Concluir</a>
                         {% endif %}
                         <a href="{% url 'editar_tarefa' tarefa.id %}">Editar</a>
                         <a href="{% url 'excluir_tarefa' tarefa.id %}" onclick="return confirmarExclusao();">Excluir</a>
                     </div>
                 </li>
             {% empty %}
                 <li>Nenhuma tarefa adicionada.</li>
             {% endfor %}
         </ul>
     </div>
     {% endblock %}
     ```

   - Certifique-se de que o link "Excluir" chama a função `confirmarExclusao()` do `script.js`.

#### Parte 3: Melhorar os templates

1. **Criar um template base para reutilização**

   - Já criamos o `base.html` na etapa anterior. Assegure-se de que todos os templates estendem este arquivo base.

2. **Melhorar a organização e estilo dos templates**

   - Use elementos semânticos do HTML5 (`<header>`, `<nav>`, `<main>`, `<footer>`) para melhorar a estrutura.
   - Utilize classes CSS para estilizar elementos de forma consistente.

   - Exemplo de atualização no `editar_tarefa.html`:

     ```html
     {% extends 'base.html' %}
     {% block title %}Editar Tarefa{% endblock %}
     {% block content %}
     <h2>Editar Tarefa</h2>
     <form method="POST" class="form-editar-tarefa">
         {% csrf_token %}
         <input type="text" name="titulo" value="{{ tarefa.titulo }}" required>
         <button type="submit">Salvar</button>
         <a href="{% url 'lista_tarefas' %}">Cancelar</a>
     </form>
     {% endblock %}
     ```

   - Atualize o CSS para estilizar o formulário de edição.

3. **Adicionar feedback visual e menu**

   - Inclua mensagens de sucesso ou erro utilizando o framework de mensagens do Django, como mostrado anteriormente.
   - Estilize as mensagens no CSS para que elas se destaquem:

     ```css
     .messages {
         list-style: none;
         padding: 0;
         margin: 10px 0;
     }

     .messages li {
         padding: 10px;
         margin-bottom: 5px;
     }

     .messages li.success {
         background-color: #d4edda;
         color: #155724;
         border: 1px solid #c3e6cb;
     }

     .messages li.error {
         background-color: #f8d7da;
         color: #721c24;
         border: 1px solid #f5c6cb;
     }

     .navbar {
        background-color: #333;
        color: #fff;
        padding: 10px 20px;
        font-family: Arial, sans-serif;
     }

     .navbar-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1200px;
        margin: 0 auto;
     }

     .navbar-brand {
        font-size: 20px;
        color: #fff;
        text-decoration: none;
     }

     .navbar-menu {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
        gap: 15px;
     }

     .navbar-menu li {
        display: inline;
     }

     .navbar-menu a {
        color: #fff;
        text-decoration: none;
        font-size: 16px;
        transition: color 0.3s ease;
     }

     .navbar-menu a:hover {
        color: #007BFF;
     }

     .navbar-toggle {
        display: none;
        background: none;
        border: none;
        color: #fff;
        font-size: 24px;
        cursor: pointer;
     }

     @media (max-width: 768px) {
        .navbar-menu {
            display: none;
            flex-direction: column;
            gap: 10px;
            background-color: #333;
            padding: 10px;
            position: absolute;
            top: 60px;
            right: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }

        .navbar-menu.active {
            display: flex;
        }

        .navbar-toggle {
            display: block;
        }
     }
     ```

4. **Atualizar o templates `login.html`**

   - Utilize classes CSS para estilizar elementos de forma consistente.
   - Exemplo de atualização no `login.html`:

     ```html
        {% load static %}
        <!DOCTYPE html>
        <html lang="pt-BR">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Login</title>
            <link rel="stylesheet" href="{% static 'css/style.css' %}">
        </head>
        <body>
            <div class="login-container">
                <h2>Login</h2>
                <form method="POST" class="login-form">
                    {% csrf_token %}
                    {{ form.as_p }}
                    <button type="submit">Entrar</button>
                </form>
                <a href="{% url 'password_reset' %}" class="password-reset-link">Esqueci minha senha</a>
            </div>
        </body>
        </html>
     ```

5. **Adicionar estilo visual na página login**
   - Estilize as mensagens no CSS para que elas se destaquem:

    ```css
     .login-container {
        width: 100%;
        max-width: 400px;
        margin: 50px auto;
        padding: 20px;
        background-color: #fff;
        border: 1px solid #ccc;
        border-radius: 10px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        text-align: justify;
     }

     .login-container h2 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #333;
     }

     .login-form {
        display: flex;
        flex-direction: column;
        gap: 15px;
     }

     .login-form input[type="text"],
     .login-form input[type="password"] {
        width: 96%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
     }

     .login-form button {
        padding: 10px 15px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease;
     }

     .login-form button:hover {
        background-color: #0056b3;
     }

     .password-reset-link {
        display: block;
        margin-top: 15px;
        font-size: 14px;
        text-decoration: none;
        color: #007BFF;
        transition: color 0.3s ease;
     }

     .password-reset-link:hover {
        color: #0056b3;
     }
    ```

6. **Atualizar o templates `lista_tarefa.html` para incluir estilização no botão sair**

   - Utilize classes CSS para estilizar elementos de forma consistente.
   - Exemplo de atualização no `lista_tarefa.html`:

     ```html
     <div class="user-auth">
        {% if user.is_authenticated %}
        <p>
            Bem-vindo, <strong>{{ user.username }}</strong>!
        <form action="{% url 'logout' %}" method="post" class="logout-form">
            {% csrf_token %}
            <button type="submit" class="logout-button">Sair</button>
        </form>
        </p>
        {% else %}
        <a href="{% url 'login' %}" class="login-link">Entrar</a>
        {% endif %}
     </div>
     ```

7. **Adicionar estilo visual na página lista_tarefas**
   - Estilize as mensagens no CSS para que elas se destaquem:

    ```css
     .user-auth {
        text-align: right;
        margin: 10px;
        font-size: 14px;
        color: #333;
     }

     .user-auth p {
        margin: 0;
        display: inline-block;
     }

     .user-auth .logout-form {
        display: inline;
        margin: 0;
     }

     .user-auth .logout-button {
        padding: 5px 10px;
        background-color: #007BFF;
        color: #fff;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease;
        margin-left: 5px;
     }

     .user-auth .logout-button:hover {
        background-color: #0056b3;
     }

     .user-auth .login-link {
        text-decoration: none;
        color: #007BFF;
        font-size: 14px;
        transition: color 0.3s ease;
     }

     .user-auth .login-link:hover {
        color: #0056b3;
     }
    ```

#### Parte 4: Melhorar o modelo (`models.py`)

1. **Adicionar validações e métodos úteis no modelo `Tarefa`**

   - No arquivo `models.py`, você pode adicionar métodos auxiliares ou propriedades:

     ```python
     from django.db import models
     from django.contrib.auth.models import User

     class Tarefa(models.Model):
         titulo = models.CharField(max_length=100, unique=True)
         concluida = models.BooleanField(default=False)
         usuario = models.ForeignKey(User, on_delete=models.CASCADE, null=True)

         def __str__(self):
             return self.titulo

         class Meta:
             ordering = ['-id']  # Exemplo: ordenar tarefas pela mais recente
     ```

2. **Adicionar validações personalizadas**

   - Você pode adicionar métodos `clean()` ou utilizar `validators` para garantir a integridade dos dados.

   - Exemplo de validação para impedir títulos duplicados para o mesmo usuário:

     ```python
     from django.core.exceptions import ValidationError

     class Tarefa(models.Model):
         # Campos já existentes...

         def clean(self):
             if Tarefa.objects.filter(titulo=self.titulo, usuario=self.usuario).exclude(id=self.id).exists():
                 raise ValidationError('Você já possui uma tarefa com este título.')
     ```

3. **Aplicar as migrações se necessário**

   - Se você fez alterações que requerem migrações, execute:

     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```

4. **Atualizar as views para lidar com validações**

   - No `views.py`, atualize as funções para lidar com possíveis erros de validação:

     ```python
     from django.contrib import messages
     from django.core.exceptions import ValidationError

     @login_required
     def lista_tarefas(request):
         if request.method == 'POST':
             titulo = request.POST.get('titulo')
             if titulo:
                 tarefa = Tarefa(titulo=titulo, usuario=request.user)
                 try:
                     tarefa.full_clean()
                     tarefa.save()
                     messages.success(request, 'Tarefa adicionada com sucesso!')
                 except ValidationError as e:
                     messages.error(request, e.message_dict['titulo'][0])
             else:
                 messages.error(request, 'O título da tarefa não pode ser vazio.')

             return redirect('lista_tarefas')

         tarefas = Tarefa.objects.filter(usuario=request.user)
         return render(request, 'lista_tarefas.html', {'tarefas': tarefas})
     ```

#### Parte 5: Melhorar a experiência do usuário

1. **Adicionar confirmação de exclusão**

   - Já incluímos uma função JavaScript para confirmar a exclusão de uma tarefa.

2. **Melhorar a navegação**

   - Adicione links de navegação para facilitar o acesso às diferentes partes da aplicação.

   - Por exemplo, no `base.html`, adicione um menu:

     ```html
     <nav class="navbar">
        <div class="navbar-container">
            <a href="{% url 'lista_tarefas' %}" class="navbar-brand">Minha Lista de Tarefas</a>
                <ul class="navbar-menu">
                    <li><a href="{% url 'lista_tarefas' %}">Início</a></li>
                    {% if user.is_authenticated %}
                    <li><a href="{% url 'lista_tarefas' %}">Minhas tarefas</a></li>
                    {% else %}
                    <li><a href="{% url 'login' %}">Entrar</a></li>
                    {% endif %}
                </ul>
            </div>
        </nav>
     ```

   - Estilize o menu no CSS para que fique agradável visualmente.

### Próximos passos 🚀

[👉 Continue para o próximo material!](https://github.com/Dev-UniRios/Python-Django-Course/blob/main/Django/5%C2%BA%20-%20etapa.md)
