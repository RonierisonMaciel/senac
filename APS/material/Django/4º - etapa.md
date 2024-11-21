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
     /* tarefas/static/css/style.css */

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

     .form-adicionar-tarefa input[type="text"] {
         width: 70%;
         padding: 5px;
         margin-right: 5px;
     }

     .form-adicionar-tarefa button {
         padding: 5px 10px;
     }

     .lista-tarefas {
         list-style: none;
         padding: 0;
     }

     .lista-tarefas li {
         background: #fff;
         margin-bottom: 5px;
         padding: 10px;
         border: 1px solid #ccc;
         display: flex;
         justify-content: space-between;
         align-items: center;
     }

     .lista-tarefas li a {
         margin-left: 10px;
         text-decoration: none;
         color: #007BFF;
     }

     .lista-tarefas li a:hover {
         text-decoration: underline;
     }
     ```

3. **Adicionar arquivos JavaScript**

   - Se necessário, crie um arquivo `script.js` dentro de `tarefas/static/js/`.
   - Adicione scripts JavaScript para melhorar a interatividade da aplicação. Por exemplo, você pode adicionar uma confirmação antes de excluir uma tarefa:

     ```javascript
     // tarefas/static/js/script.js

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
     # lista_de_tarefas/settings.py

     STATIC_URL = '/static/'

     # Para desenvolvimento, certifique-se de que STATIC_ROOT está configurado:
     import os
     
     STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
     ```

2. **Carregar a tag `static` nos Templates**

   - No início dos seus templates, carregue a tag `static`:

     ```django
     {% load static %}
     ```

3. **Referenciar arquivos estáticos nos templates**

   - No arquivo `base.html` ou nos templates específicos, inclua os arquivos CSS e JS:

     ```html
     <!-- templates/base.html -->
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

         <!-- Scripts JavaScript -->
         <script src="{% static 'js/script.js' %}"></script>
     </body>
     </html>
     ```

4. **Atualizar os templates para usar classes e IDs do CSS**

   - No `lista_tarefas.html`, adicione classes ou IDs aos elementos para aplicar os estilos definidos:

     ```html
     <!-- tarefas/templates/tarefas/lista_tarefas.html -->
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
     <!-- tarefas/templates/tarefas/editar_tarefa.html -->
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

3. **Adicionar feedback visual**

   - Inclua mensagens de sucesso ou erro utilizando o framework de mensagens do Django, como mostrado anteriormente.
   - Estilize as mensagens no CSS para que elas se destaquem:

     ```css
     /* tarefas/static/tarefas/css/estilo.css */

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
     ```

#### Parte 4: Melhorar o modelo (`models.py`)

1. **Adicionar validações e métodos úteis no modelo `Tarefa`**

   - No arquivo `models.py`, você pode adicionar métodos auxiliares ou propriedades:

     ```python
     # tarefas/models.py

     from django.db import models
     from django.contrib.auth.models import User

     class Tarefa(models.Model):
         titulo = models.CharField(max_length=100)
         concluida = models.BooleanField(default=False)
         usuario = models.ForeignKey(User, on_delete=models.CASCADE)

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
     # tarefas/views.py

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
     <!-- templates/base.html -->
     <nav>
         <ul>
             <li><a href="{% url 'lista_tarefas' %}">Início</a></li>
             {% if user.is_authenticated %}
                 <li><a href="{% url 'lista_tarefas' %}">Minhas Tarefas</a></li>
             {% else %}
                 <li><a href="{% url 'login' %}">Entrar</a></li>
             {% endif %}
         </ul>
     </nav>
     ```

   - Estilize o menu no CSS para que fique agradável visualmente.

---
