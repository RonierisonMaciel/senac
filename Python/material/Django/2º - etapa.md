# 2º To-Do List com Django

## Objetivo

Criar uma aplicação de lista de tarefas em Django, permitindo que os usuários adicionem e visualizem tarefas em uma página HTML simples.

---

### Passo a passo

#### Parte 1: Adicionar um modelo `Tarefa` para armazenar as tarefas

1. **Definir o modelo `Tarefa`**:
   - No arquivo `models.py` da aplicação `tarefas`, adicione um modelo para representar as tarefas:
     ```python
     from django.db import models

     class Tarefa(models.Model):
         titulo = models.CharField(max_length=100)
         concluida = models.BooleanField(default=False)

         def __str__(self):
             return self.titulo
     ```

   - Aqui, cada `Tarefa` tem um campo `titulo` para o nome da tarefa e um campo `concluída` que indica se a tarefa foi concluída.

2. **Criar e aplicar as migrações**:
   - No terminal, execute os comandos para criar e aplicar as migrações, o que criará a tabela `Tarefa` no banco de dados:
     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```

---

#### Parte 2: Ajustar a view para buscar tarefas do banco de dados

1. **Modificar a view `lista_tarefas`**:
   - No arquivo `views.py` da aplicação `tarefas`, ajuste a view para buscar as tarefas do banco de dados:
     ```python
     from django.shortcuts import render
     from .models import Tarefa

     def lista_tarefas(request):
         tarefas = Tarefa.objects.all()
         return render(request, 'lista_tarefas.html', {'tarefas': tarefas})
     ```

   - Agora, a view `lista_tarefas` busca todas as tarefas armazenadas no banco de dados e as passa para o template.

2. **Atualizar o template `lista_tarefas.html`**:
   - No arquivo `lista_tarefas.html`, mantenha o loop `for` para exibir as tarefas:
     ```html
     <!DOCTYPE html>
     <html lang="pt-BR">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Lista de Tarefas</title>
     </head>
     <body>
         <h1>Minha Lista de Tarefas</h1>
         <ul>
             {% for tarefa in tarefas %}
                 <li>{{ tarefa.titulo }} - {% if tarefa.concluida %}Concluída{% else %}Pendente{% endif %}</li>
             {% endfor %}
         </ul>
     </body>
     </html>
     ```

   - O template agora exibe as tarefas e indica se cada uma está concluída ou pendente.

---

#### Parte 3: Criar um formulário para adicionar novas tarefas

1. **Adicionar um formulário no template `lista_tarefas.html`**:
   - Adicione um formulário simples para permitir que o usuário adicione novas tarefas diretamente pela interface:
     ```html
     <!DOCTYPE html>
     <html lang="pt-BR">
     <head>
         <meta charset="UTF-8">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <title>Lista de Tarefas</title>
     </head>
     <body>
         <h1>Minha Lista de Tarefas</h1>
         
         <form method="POST">
             {% csrf_token %}
             <input type="text" name="titulo" placeholder="Adicione uma nova tarefa" required>
             <button type="submit">Adicionar</button>
         </form>

         <ul>
             {% for tarefa in tarefas %}
                 <li>{{ tarefa.titulo }} - {% if tarefa.concluida %}Concluída{% else %}Pendente{% endif %}</li>
             {% endfor %}
         </ul>
     </body>
     </html>
     ```

   - O formulário utiliza o método `POST` para enviar o título da nova tarefa e inclui a tag `{% csrf_token %}` para proteger contra ataques CSRF.

2. **Atualizar a view `lista_tarefas` para processar o formulário**:
   - Modifique a view `lista_tarefas` para lidar com a criação de novas tarefas:
     ```python
     from django.shortcuts import render, redirect
     from .models import Tarefa

     def lista_tarefas(request):
         if request.method == 'POST':
             titulo = request.POST.get('titulo')
             if titulo:
                 Tarefa.objects.create(titulo=titulo)
                 return redirect('lista_tarefas')

         tarefas = Tarefa.objects.all()
         return render(request, 'lista_tarefas.html', {'tarefas': tarefas})
     ```

   - Agora, a view verifica se a requisição é `POST` e, se um título for fornecido, cria uma nova tarefa e redireciona para a página de lista de tarefas, atualizando a lista.

3. **Testar a adição de novas tarefas**:
   - No terminal, inicie o servidor:
     ```bash
     python manage.py runserver
     ```
   - Acesse `http://127.0.0.1:8000/` e adicione algumas tarefas pelo formulário.
   - Verifique se as tarefas aparecem na lista abaixo do formulário.

---

### Próximos passos 🚀

[👉 Continue para o próximo material!](https://github.com/RonierisonMaciel/senac/blob/main/Python/material/Django/3%C2%BA%20-%20etapa.md)
