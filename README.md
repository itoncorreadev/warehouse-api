# 🏛️ Warehouse (Backend)
Projeto agenda com backend Ruby on Rails API e frontend em Angular e Monile em NativeScript

## 🚀 Começando
Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.

Consulte **Implantação** para saber como implantar o projeto.

## 📋 Pré-requisitos

```
Docker Desktop
```

## 🔧 Instalação do Docker 🐳
Siga os passos nos links abaixo para instalação do Docker de acordo com seu sistema operacional:

* [Como instalar o Docker](https://docs.docker.com/engine/installation/)
* [Como instalar o Docker Compose](https://docs.docker.com/compose/)

## ⚙️ Build do Projeto
Para fazer o Build de todos os nossos containers basta rodar (dentro do projeto):

```
docker-compose build
```

Agora precisamos criar nosso banco de dados e rodar as migrações e seeds, utilizando o docker-compose para fazer isso de maneira fácil. No console rode:

```
docker-compose run application rake db:create db:migrate db:seed
```

Para subir nossos containers, rode no console:

```
docker-compose up
```

Para rodar em background utilize o _-d_ após i _up_:

```
docker-compose up -d
```

## ⚙️ Executando os testes

No diretório do projeto rode o comando:

```
docker-compose run application bundle exec spring rspec
```

## 🛠️ Construído com

* [Gem Rails](https://github.com/rails/rails/)
* [Gem Devise Token Auth](https://github.com/heartcombo/devise)
* [Gem Versionist](https://github.com/bploetz/versionist)
* [Gem Kaminari](https://github.com/kaminari/kaminari)
* [Gem Faker](https://github.com/faker-ruby/faker)
* [Gem Rspec Rails](https://github.com/rspec/rspec-rails)
* [Gem Shouda Matchers](https://github.com/thoughtbot/shoulda-matchers)
* [Gem Factory Bot](https://github.com/thoughtbot/factory_bot)

## ✒️ Autores

* **Cleiton Corrêa** - *Trabalho Inicial* - [Developer](https://github.com/cleitoncorreas)

## 📄 Licença

Este projeto está sob a licença OpenSource - veja o arquivo [LICENSE.md](https://github.com/cleitoncorreas/notebook_api/LICENSE.md) para detalhes.

## 🎁 Gratidão

* Projeto utilizado para fins de estudo 📢.
* Obrigado a todos que ajudaram no projeto 🤓.


---
⌨️ com ❤️ por [Cleiton Corrêa](https://github.com/cleitoncorreas) 😊
