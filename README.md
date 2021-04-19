<p align="center">
  <img src="https://github.com/cleitoncorreas/cleitoncorreas/blob/4f8429a4aeb5426d89d7ae703ede280d06e8df20/Projetos/Warehouse/Logo/logo.png"  width="200" height="200"/>
</p>
<br>
<p align="center">
  <img src="https://github.com/cleitoncorreas/cleitoncorreas/blob/4fa53ca31d1bf2a525be593615104f1bbea71da9/Projetos/Warehouse/Capa/capa-warehouse.png"/>
</p>

# 🏛️ Warehouse (Backend)
Projeto agenda com backend Ruby on Rails API e frontend em Angular e Monile em NativeScript

## 🌐 Heroku
https://warehouse-angular-web.herokuapp.com

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

## ⬇️ Clonar o projeto
Para obter uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste execute o comando abaixo:

```
git clone https://github.com/cleitoncorreas/warehouse-api.git
```

logo após o download, entre na pasta do projeto

```
cd warehouse-api
```

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

Containers Postgres, Redis, Sidekiq e da Aplicação

<p align="center">
  <img src="https://github.com/cleitoncorreas/cleitoncorreas/blob/3eb3422a4aa3755dfda42d92351e962069a1e6d1/Images/docker-containers.png"/>
</p>

## 📉 Monitoramento Sidekiq

```
http://localhost:3000/sidekiq
```

<p align="center">
  <img src="https://github.com/cleitoncorreas/cleitoncorreas/blob/3eb3422a4aa3755dfda42d92351e962069a1e6d1/Images/Sidekiq.png"/>
</p>


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
* [Gem Redis](https://github.com/redis/redis-rb/)
* [Gem Sidekiq](https://github.com/mperham/sidekiq)

## ✒️ Autores

* **Cleiton Corrêa** - *Trabalho Inicial* - [Developer](https://github.com/cleitoncorreas)

## 📄 Licença

Este projeto está sob a licença OpenSource - veja o arquivo [LICENSE.md](https://github.com/cleitoncorreas/notebook_api/LICENSE.md) para detalhes.

## 🎁 Gratidão

* Projeto utilizado para fins de estudo 📢.
* Obrigado a todos que ajudaram no projeto 🤓.


---
⌨️ com ❤️ por [Cleiton Corrêa](https://github.com/cleitoncorreas) 😊
