# 7º To-Do List com Django

## Objetivo

Aprimorar a funcionalidade de upload de imagens, adicionando miniaturas e redimensionamento, garantindo que apenas tipos de arquivos permitidos sejam enviados, limitando o tamanho das imagens e melhorando a interface de exibição. Além disso, implementar a exclusão de imagens órfãs quando uma tarefa é excluída.

---

### Passo a passo

#### Parte 1: Adicionar miniaturas e redimensionamento

1. **Configurar variações de imagem no modelo `Tarefa`**

   - No arquivo `models.py`, ajuste o campo `imagem` para incluir variações de imagem com tamanhos específicos:

     ```python
     from stdimage.models import StdImageField

     class Tarefa(models.Model):
         # Campos existentes...
         imagem = StdImageField(
             upload_to='tarefas',
             variations={
                 'thumb': {"width": 100, "height": 100, "crop": True},
                 'medium': {"width": 300, "height": 300},
             },
             blank=True,
             null=True
         )
     ```

     - A variação `thumb` cria uma miniatura de 100x100 pixels com corte para ajustar ao tamanho.
     - A variação `medium` redimensiona a imagem para no máximo 300x300 pixels, mantendo a proporção.

2. **Aplicar as migrações**

   - Crie e aplique as migrações para atualizar o banco de dados:

     ```bash
     python manage.py makemigrations
     python manage.py migrate
     ```

3. **Atualizar os templates para utilizar as variações**

   - No template `lista_tarefas.html`, ajuste o código para exibir a miniatura em vez da imagem original:

     ```html
     {% if tarefa.imagem %}
         <img src="{{ tarefa.imagem.thumb.url }}" alt="{{ tarefa.titulo }}" class="img-thumbnail me-2">
     {% endif %}
     ```

   - No template `editar_tarefa.html`, se desejar exibir a imagem atual, use a variação apropriada:

     ```html
     {% if form.instance.imagem %}
         <img src="{{ form.instance.imagem.medium.url }}" alt="{{ form.instance.titulo }}" class="img-fluid mb-3">
     {% endif %}
     ```

#### Parte 2: Excluir imagens órfãs

1. **Adicionar um sinal (`Signal`) para excluir imagens quando uma tarefa é excluída**

   - Crie um arquivo `signals.py` dentro da aplicação `tarefas` (se ainda não existir).

     ```python
     from django.db.models.signals import post_delete
     from django.dispatch import receiver
     from .models import Tarefa

     @receiver(post_delete, sender=Tarefa)
     def tarefa_post_delete(sender, instance, **kwargs):
         if instance.imagem:
             instance.imagem.delete(False)
     ```

2. **Registrar o sinal na aplicação**

   - No arquivo `apps.py` da aplicação `tarefas`, importe o módulo de sinais na classe `TarefasConfig`:

     ```python
     from django.apps import AppConfig

     class TarefasConfig(AppConfig):
         name = 'tarefas'

         def ready(self):
             import tarefas.signals
     ```

   - Certifique-se de que o `default_app_config` está definido no `__init__.py` da aplicação:

     ```python
     default_app_config = 'tarefas.apps.TarefasConfig'
     ```

3. **Testar a exclusão de imagens**

   - Exclua uma tarefa que possui uma imagem e verifique se o arquivo de imagem correspondente foi removido do sistema de arquivos.

#### Parte 3: Melhorar a interface

1. **Ajustar o layout das imagens nas tarefas**

   - No template `lista_tarefas.html`, estilize a exibição das imagens para melhor alinhamento e apresentação:

     ```html
     <li class="list-group-item">
         <div class="row align-items-center">
             <div class="col-auto">
                 {% if tarefa.imagem %}
                     <img src="{{ tarefa.imagem.thumb.url }}" alt="{{ tarefa.titulo }}" class="img-thumbnail" style="width: 50px; height: 50px;">
                 {% endif %}
             </div>
             <div class="col">
                 {% if tarefa.concluida %}
                     <s>{{ tarefa.titulo }}</s>
                 {% else %}
                     {{ tarefa.titulo }}
                 {% endif %}
             </div>
             <div class="col-auto">
                 <!-- Botões de ação -->
             </div>
         </div>
     </li>
     ```

2. **Adicionar estilos CSS personalizados se necessário**

   - Se precisar de ajustes adicionais, edite o arquivo `estilo.css` para melhorar a aparência das imagens e do layout.

#### Parte 4: Validar tipos de arquivo permitidos

1. **Adicionar validação no formulário**

   - No arquivo `forms.py`, adicione um método `clean_imagem` para validar o tipo de arquivo:

     ```python
     from django import forms
     from django.core.exceptions import ValidationError
     from django.core.validators import FileExtensionValidator
     from tarefas.models import Tarefa

     class TarefaForm(forms.ModelForm):
         imagem = forms.ImageField(required=False, validators=[
             FileExtensionValidator(allowed_extensions=['jpg', 'jpeg', 'png'])
         ])

         class Meta:
             model = Tarefa
             fields = ['titulo', 'imagem']

         def clean_imagem(self):
             imagem = self.cleaned_data.get('imagem', False)
             if imagem:
                 if not imagem.content_type in ["image/jpeg", "image/png"]:
                     raise ValidationError("Tipos de arquivo permitidos: JPEG ou PNG.")
             return imagem
     ```

2. **Exibir mensagens de erro no template**

   - Certifique-se de que os erros de formulário são exibidos no template:

     ```html
     {% if form.errors %}
         <div class="alert alert-danger">
             {{ form.errors }}
         </div>
     {% endif %}
     ```

#### Parte 5: Limitar o tamanho das imagens

1. **Adicionar validação de tamanho no formulário**

   - No `forms.py`, adicione uma verificação para o tamanho máximo do arquivo (por exemplo, 2 MB):

     ```python
     class TarefaForm(forms.ModelForm):
         # Campos e validações existentes...

         MAX_UPLOAD_SIZE = 2 * 1024 * 1024  # 2 MB

         def clean_imagem(self):
             imagem = self.cleaned_data.get('imagem', False)
             if imagem:
                 if imagem.size > self.MAX_UPLOAD_SIZE:
                     raise ValidationError("A imagem não pode exceder 2 MB.")
                 # Verificação de tipo de conteúdo...
             return imagem
     ```

2. **Exibir mensagens de erro no template**

   - As mensagens de erro já serão exibidas conforme configurado anteriormente.

#### Parte 6: Testar as novas funcionalidades

1. **Iniciar o servidor de desenvolvimento**

   ```bash
   python manage.py runserver
