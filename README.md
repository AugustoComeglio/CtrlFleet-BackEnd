# README --> ctrlfleet-backend

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version

3.2.2

## Configuration

### Local

Instrucciones para levantar el proyecto en local

1. Instalar ruby y rails (con rvm -> https://rvm.io/rvm/install)

- Run:

  ```ruby
  $ rvm list
  => ruby-3.2.2 [ arm64 ]

  $ rails -v
  Rails 7.0.5

  $ ruby -v
  ruby 2.7.6p219
  ```

2. Instalar postgres (https://computingforgeeks.com/how-to-install-postgresql-13-on-ubuntu/)

- Run:

  ```ruby
  $ postgres --version
  postgres (PostgreSQL) 13.10
  ```

3. Instalar Docker (https://docs.docker.com/engine/install/ubuntu/)

- Run:

  ```ruby
  $ docker -v
  Docker version 24.0.2, build cb74dfc

  $ docker compose version
  Docker Compose version v2.19.1
  ```

4. Levantar el proyecto

- Run:
  ```ruby
  $ rails server
  ```

5. Para hacer Debugging

```ruby
  binding.break
```

### Docker

Instrucciones para levantar el proyecto con Docker

1. Instalar Docker Desktop

2. Generar contenedores del proyecto

En terminal ejecutar uno de los siguientes comandos

```ruby
$ docker-compose up --build # Ejecuta el build y el run, dejando los logs de docker abiertos
$ docker-compose up -d      # Ejecuta el build y el run en background
```

Luego de tener los contendores corriendo y en ejecucion, en una terminal de comando debo ejecutar

```ruby
$ docker-compose run web bundle exec rails db:migrate
$ docker-compose run web bundle exec rails db:seed
```

En caso de necesitar ejecutar comando o queries rails, podemos abrir una consola de rails usando

```ruby
$ docker-compose run web bundle exec rails console
```

Reestablecer la base de datos

```ruby
$ docker-compose run web bundle exec rails db:drop
$ docker-compose run web bundle exec rails db:create
$ docker-compose run web bundle exec rails db:migrate
$ docker-compose run web bundle exec rails db:seed
```

### PostgreSQL

- Database creation
  Run:

```ruby
  $ rails db:create
  $ rails db:migrate
```

- Database initialization

```ruby
  $ rails db:seed
```

### Test

- Como correr los test unitarios en entorno local
  Run:

```ruby
  $ bundle exec rspec spec
  # spec es la carpeta que contiene los tests, podemos correr toda la carpeta o el test particular que necesitemos probar
```

- Como correr los test unitarios en el contedor docker
  Run:

```ruby
  $ docker-compose run web bundle exec rspec spec
  # spec es la carpeta que contiene los tests, podemos correr toda la carpeta o el test particular que necesitemos probar
```
