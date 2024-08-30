# Termos de análise e projeto de sistemas com exemplos de uso

## Histórico e Evolução da Engenharia de Software

- **Software Engineering** (Engenharia de Software): Disciplina que envolve a aplicação de uma abordagem sistemática, disciplinada e quantificável para o desenvolvimento, operação e manutenção de software.
  
  Exemplo: Desenvolvimento de software usando metodologias ágeis para garantir qualidade e eficiência.

- **Waterfall Model** (Modelo Cascata): Um modelo de ciclo de vida de desenvolvimento de software linear e sequencial, onde cada fase deve ser completada antes que a próxima comece.
  
  Exemplo: Um projeto de software que segue as fases de Requisitos -> Design -> Implementação -> Teste -> Manutenção.

## Estilos e padrões de arquitetura de sistemas

- **Layered Architecture** (Arquitetura em Camadas): Um estilo arquitetural onde os componentes do sistema são organizados em camadas, sendo cada uma delas responsável por uma parte específica da funcionalidade.
  
  Exemplo: Arquitetura de três camadas com apresentação, lógica de negócios e acesso a dados.

- **Client-Server Architecture** (Arquitetura Cliente-Servidor): Um modelo de computação onde o servidor fornece serviços para clientes que solicitam dados ou operações.
  
  Exemplo: Aplicação web onde o navegador atua como cliente e o servidor de back-end processa as requisições.

## Arquitetura orientada a serviço (SOA)

- **XML (eXtensible Markup Language)**: Linguagem de marcação usada para armazenar e transportar dados de forma legível tanto por humanos quanto por máquinas.
  
  Exemplo: Troca de dados entre sistemas diferentes usando arquivos XML.

- **JSON (JavaScript Object Notation)**: Um formato leve de troca de dados, fácil de ler e escrever, amplamente utilizado em APIs modernas.
  
  Exemplo: API REST que retorna dados de usuários em formato JSON.

- **REST (Representational State Transfer)**: Um estilo arquitetural para a construção de serviços web escaláveis usando métodos HTTP padrão.
  
  Exemplo: Endpoint RESTful para listar todos os produtos: `GET /api/produtos`.

- **SOAP (Simple Object Access Protocol)**: Um protocolo baseado em XML para troca de informações estruturadas em redes computacionais.
  
  Exemplo: Serviço web SOAP para operações de banco que usa mensagens XML.

## Processo de desenvolvimento de software

- **Software Development Lifecycle (SDLC)** (Ciclo de Vida de Desenvolvimento de Software): O processo de planejamento, criação, teste e implantação de um sistema de software.
  
  Exemplo: SDLC inclui fases como planejamento, análise de requisitos, design, implementação, teste, e manutenção.

- **Agile Methodology** (Metodologia Ágil): Uma abordagem de desenvolvimento de software que enfatiza a flexibilidade, colaboração, e entregas incrementais de produtos.
  
  Exemplo: Uso de Scrum ou Kanban para gerenciar projetos de software de forma ágil.

## Problemas e práticas recomendadas no desenvolvimento de software

- **Technical Debt** (Dívida Técnica): Metáfora para representar o custo implícito de retrabalho causado pela escolha de uma solução mais fácil em vez de uma abordagem melhor a longo prazo.
  
  Exemplo: Adiar refatoração de código para entregar um recurso mais rapidamente, resultando em código menos manutenível.

- **Code Review** (Revisão de Código): O processo de revisão de código escrito por outros desenvolvedores para garantir qualidade e detectar problemas.
  
  Exemplo: Uso de ferramentas como GitHub para revisão de código em pull requests.

## Modelagem de sistemas com UML

- **UML (Unified Modeling Language)**: Linguagem de modelagem padrão para especificação, visualização e documentação de sistemas de software.
  
  Exemplo: Uso de diagramas de classe UML para representar a estrutura de um sistema de gerenciamento de biblioteca.

- **Class Diagram** (Diagrama de Classe): Um tipo de diagrama UML que mostra a estrutura de um sistema representando suas classes, atributos, operações e relacionamentos.
  
  Exemplo: Diagrama de classes para um sistema de e-commerce mostrando entidades como Produto, Pedido e Cliente.

## Ciclo de vida do software e refatoração de código

- **Software Lifecycle** (Ciclo de Vida do Software): As fases pelas quais um sistema de software passa, desde a concepção até o desuso.
  
  Exemplo: Fases como desenvolvimento, lançamento, manutenção e descontinuação.

- **Refactoring** (Refatoração): O processo de reestruturar o código existente sem alterar seu comportamento externo para melhorar a legibilidade, reduzir a complexidade e melhorar a manutenção.
  
  Exemplo: Renomear variáveis para tornar o código mais legível e reorganizar funções longas em funções menores.

## Linhas de produto de software

- **Software Product Line (Linha de Produto de Software)**: Uma coleção de produtos de software que compartilham um conjunto comum de funcionalidades, construídas a partir de um conjunto compartilhado de componentes.
  
  Exemplo: Vários produtos de software de uma empresa que utilizam a mesma base de código com customizações específicas.

- **Reuse** (Reuso): A prática de usar componentes ou funcionalidades existentes em novos projetos para economizar tempo e esforço.
  
  Exemplo: Uso de bibliotecas de código abertas para adicionar autenticação a um novo projeto.

## Gestão de configuração e mudanças

- **Configuration Management** (Gestão de Configuração): O processo de rastrear e controlar mudanças no software para garantir a consistência e a qualidade durante o ciclo de vida do produto.
  
  Exemplo: Uso de ferramentas de controle de versão como Git para gerenciar alterações no código-fonte.

- **Change Management** (Gestão de Mudanças): O processo de identificar, documentar, analisar e aprovar mudanças no projeto de software.
  
  Exemplo: Procedimentos para solicitar e aprovar mudanças em requisitos do cliente.

## Padrões de projeto de software orientados a objetos

- **Design Patterns** (Padrões de Projeto): Soluções reutilizáveis e bem definidas para problemas comuns de design de software.
  
  Exemplo: Uso do padrão Singleton para garantir que uma classe tenha apenas uma instância.

- **Observer Pattern** (Padrão Observador): Um padrão de design onde um objeto, conhecido como observador, recebe notificações sobre mudanças de estado em outro objeto.
  
  Exemplo: Implementação de observadores em uma aplicação de eventos para atualizar a interface do usuário quando o modelo de dados é alterado.

## Gerenciamento de versões e configurações

- **Version Control** (Controle de Versão): Sistema que registra alterações em arquivos ao longo do tempo para que versões específicas possam ser recuperadas posteriormente.
  
  Exemplo: Git, um sistema de controle de versão distribuído, é amplamente usado em projetos de desenvolvimento de software.

- **Branching** (Ramificação): Criar ramificações (branches) no controle de versão para desenvolver funcionalidades isoladamente sem afetar a base de código principal.
  
  Exemplo: Criar um branch para adicionar um novo recurso enquanto a equipe principal continua corrigindo bugs na versão principal.

- **Merging** (Mesclagem): Combinar mudanças de diferentes branches em um único branch para consolidar o desenvolvimento.
  
  Exemplo: Mesclar o branch de uma nova funcionalidade com o branch principal após a conclusão e teste da funcionalidade.
"""
