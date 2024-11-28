# 6º To-Do List com Django

## Objetivo

Adicionar a funcionalidade de upload de imagens às tarefas utilizando o pacote `django-stdimage`, permitindo que os usuários anexem imagens às suas tarefas.

---

### Passo a passo

#### Parte 1: Instalar e configurar o `django-stdimage`

1. **Instalar o pacote `django-stdimage`**:
   - No terminal, instale o pacote usando o `pip`:
     ```bash
     pip install django-stdimage
     ```

2. **Adicionar `stdimage` ao `INSTALLED_APPS`**:
   - No arquivo `settings.py` do projeto, adicione `'stdimage'` à lista de aplicações instaladas:
     ```python
     INSTALLED_APPS = [
         'django.contrib.admin',
         'django.contrib.auth',
         'django.contrib.contenttypes',
         'django.contrib.sessions',
         'django.contrib.messages',
         'django.contrib.staticfiles',
         'bootstrap4',
         'stdimage',
         'tarefas',
     ]
     ```

#### Parte 2: Atualizar o modelo `Tarefa` para incluir um campo de imagem

1. **Modificar o modelo `Tarefa`**:
   - No arquivo `models.py` da aplicação `tarefas`, importe `StdImageField` e adicione um campo de imagem ao modelo `Tarefa`:
     ```python
     from django.core.exceptions import ValidationError
     from django.contrib.auth.models import User
     from stdimage.models import StdImageField
     from django.db import models

     class Tarefa(models.Model):
        titulo = models.CharField(max_length=100, unique=True)
        concluida = models.BooleanField(default=False)
        usuario = models.ForeignKey(User, on_delete=models.CASCADE, null=True)
        imagem = StdImageField(upload_to='tarefas', variations={'thumb': (100, 100)}, blank=True, null=True)

        def __str__(self):
            return self.titulo

        class Meta:
            ordering = ['-id']

        def clean(self):
            if Tarefa.objects.filter(titulo=self.titulo, usuario=self.usuario).exclude(id=self.id).exists():
                raise ValidationError('Você já possui uma tarefa com este título.')
     ```

2. **Aplicar as migrações**:
   - Crie e aplique as migrações para atualizar o banco de dados:
     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```

#### Parte 3: Atualizar os formulários e views para lidar com o upload de imagens

1. **Criar ou atualizar o formulário `TarefaForm`**:
   - Crie um arquivo `forms.py` dentro da aplicação `tarefas` (se ainda não existir) e defina o `TarefaForm`:
     ```python
     from django import forms
     from .models import Tarefa

     class TarefaForm(forms.ModelForm):
         class Meta:
             model = Tarefa
             fields = ['titulo', 'imagem']
     ```

2. **Modificar a view `lista_tarefas` para usar o formulário**:
   - No arquivo `views.py`, atualize a função `lista_tarefas` para lidar com o upload de imagens:
     ```python
     from django.shortcuts import render, redirect
     from django.contrib.auth.decorators import login_required
     from django.contrib import messages
     from .models import Tarefa
     from .forms import TarefaForm

     @login_required
     def lista_tarefas(request):
         if request.method == 'POST':
             form = TarefaForm(request.POST, request.FILES)
             if form.is_valid():
                 tarefa = form.save(commit=False)
                 tarefa.usuario = request.user
                 tarefa.save()
                 messages.success(request, 'Tarefa adicionada com sucesso!')
                 return redirect('lista_tarefas')
             else:
                 messages.error(request, 'Erro ao adicionar a tarefa. Verifique os dados informados.')
         else:
             form = TarefaForm()

         tarefas = Tarefa.objects.filter(usuario=request.user)
         return render(request, 'lista_tarefas.html', {'tarefas': tarefas, 'form': form})
     ```

3. **Modificar a view `editar_tarefa` para lidar com imagens**:
   - Atualize a função `editar_tarefa` para permitir a edição da imagem:
     ```python
     @login_required
     def editar_tarefa(request, id):
         tarefa = get_object_or_404(Tarefa, id=id, usuario=request.user)
         if request.method == 'POST':
             form = TarefaForm(request.POST, request.FILES, instance=tarefa)
             if form.is_valid():
                 form.save()
                 messages.success(request, 'Tarefa atualizada com sucesso!')
                 return redirect('lista_tarefas')
             else:
                 messages.error(request, 'Erro ao atualizar a tarefa. Verifique os dados informados.')
         else:
             form = TarefaForm(instance=tarefa)

         return render(request, 'editar_tarefa.html', {'form': form})
     ```

#### Parte 4: Atualizar os templates para suportar o upload e exibição de imagens

1. **Modificar o template `lista_tarefas.html`**:
   - Atualize o template para exibir o formulário utilizando o `django-bootstrap4` e incluir o campo de imagem:
     ```html
     {% extends 'base.html' %}
     {% load bootstrap4 %}
     {% block title %}Lista de Tarefas{% endblock %}
     {% block content %}
     <h2 class="mb-4">Minhas Tarefas</h2>
        <form method="POST" enctype="multipart/form-data" class="mb-4">
            {% csrf_token %}
            {% bootstrap_form form layout='horizontal' %}
            <button type="submit" class="btn btn-primary">Adicionar</button>
        </form>

        <ul class="list-group">
            {% for tarefa in tarefas %}
                <li class="list-group-item d-flex justify-content-between align-items-center {% if tarefa.concluida %}list-group-item-success{% endif %}">
                    <div class="d-flex align-items-center">
                        {% if tarefa.imagem %}
                            <img src="{{ tarefa.imagem.url }}" alt="{{ tarefa.titulo }}" class="img-thumbnail me-2" style="width: 50px; height: 50px;">
                        {% endif %}
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
                        <a href="#" class="btn btn-sm btn-danger" data-toggle="modal" data-target="#confirmModal-{{ tarefa.id }}">Excluir</a>
                    </div>
                </li>

                <div class="modal fade" id="confirmModal-{{ tarefa.id }}" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel-{{ tarefa.id }}" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmModalLabel-{{ tarefa.id }}">Confirmar Exclusão</h5>
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

2. **Modificar o template `editar_tarefa.html`**:
   - Atualize o template para permitir a edição da imagem:
     ```html
     {% extends 'base.html' %}
     {% load bootstrap4 %}
     {% block title %}Editar Tarefa{% endblock %}
     {% block content %}
     <h2>Editar Tarefa</h2>
     <form method="POST" enctype="multipart/form-data">
         {% csrf_token %}
         {% bootstrap_form form %}
         <button type="submit" class="btn btn-primary">Salvar</button>
         <a href="{% url 'lista_tarefas' %}" class="btn btn-secondary">Cancelar</a>
     </form>
     {% endblock %}
     ```

#### Parte 5: Configurar o servidor para servir arquivos de mídia

1. **Atualizar as configurações no `settings.py`**:
   - Adicione as configurações para manipulação de arquivos de mídia:
     ```python
     MEDIA_URL = '/media/'
     MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
     ```

2. **Atualizar o `urls.py` do projeto para servir arquivos de mídia no desenvolvimento**:
   - No arquivo `urls.py` do projeto principal, adicione as configurações para servir arquivos de mídia durante o desenvolvimento:
     ```python
     from django.contrib import admin
     from django.urls import path, include
     from django.conf import settings
     from django.conf.urls.static import static

     urlpatterns = [
         path('admin/', admin.site.urls),
         path('accounts/', include('django.contrib.auth.urls')),
         path('', include('tarefas.urls')),
     ]

     if settings.DEBUG:
         urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
     ```

#### Parte 6: Testar a funcionalidade de upload de imagens

1. **Iniciar o servidor de desenvolvimento**:
   ```bash
   python manage.py runserver

### Próximos passos 🚀

[👉 Continue para o próximo material!](https://github.com/Dev-UniRios/Python-Django-Course/blob/main/Django/7%C2%BA%20-%20etapa.md)
