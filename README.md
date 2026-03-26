# API Restful de Produtos - Dart & SQLite

Projeto prático desenvolvido para a disciplina de Tópicos Especiais (Prof. Matheus Barquette
) do curso de Ciência da Computação na Atitus Educação.

## Visão Geral

O sistema consiste em uma API simples construída nativamente em Dart para o gerenciamento de um catálogo de produtos. A aplicação implementa um CRUD básico, garantindo a persistência dos dados localmente com SQLite e restringindo o acesso aos endpoints por meio de um middleware customizado.

## Tecnologias e Pacotes Utilizados

- Dart SDK
- shelf e shelf_router
- sqlite3

## Arquitetura

    api_produtos/
    ├── bin/
    │   └── server.dart (Ponto de entrada e configuração do Pipeline)
    ├── lib/
    │   ├── database/
    │   │   └── database_helper.dart (Conexão e queries SQL)
    │   ├── middlewares/
    │   │   └── auth_middleware.dart (Camada de segurança)
    │   ├── models/
    │   │   └── produto.dart (Estrutura da entidade)
    │   └── routes/
    │       └── produto_routes.dart (Definição dos endpoints)
    └── pubspec.yaml

## Autenticação e Segurança

Para consumir os serviços, é obrigatório incluir o token de acesso no Header da requisição HTTP.

    Key: Authorization
    Value: 123 (ou Bearer 123)

## Mapeamento de Rotas

    [POST] /produtos
    Registra um novo produto. (JSON) 
    {
      "nome": "Cadeira de Escritório",
      "preco": 450.00
    }

    [GET] /produtos
    Retorna todos os produtos armazenados no banco.

    [GET] /produtos/<id>
    Busca e retorna um produto específico através do ID.

    [PUT] /produtos/<id>
    Sobrescreve os dados de um produto específico.

    [DELETE] /produtos/<id>
    Remove um produto específico do banco.

## Instruções de Execução

Para iniciar o ambiente de desenvolvimento local, execute os comandos abaixo na raiz do diretório do projeto:

1. Baixe as dependências:

```dart pub get```

2. Inicialize o servidor:

```dart run bin/server.dart```
