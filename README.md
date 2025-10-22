# CtrlFleet-BackEnd
## Descripción
CtrlFleet es un sistema de gestión de flotas robusto y fácil de usar, construido con las últimas versiones de Ruby on Rails y Angular. Permite administrar vehículos, conductores, mantenimientos y más, a través de una interfaz intuitiva y completa. Este repositorio corresponde al backend de la aplicación, que expone una API RESTful para ser consumida por el frontend.

##Funcionalidades Principales
- Autenticación y Autorización: Sistema de autenticación de usuarios basado en tokens utilizando Doorkeeper, con un sistema de permisos y roles a través de CanCanCan.
- Gestión de Vehículos: Permite agregar, editar y eliminar vehículos de la flota, así como visualizar información detallada de cada uno.
- Gestión de Conductores: Ofrece la posibilidad de administrar los conductores y asignarlos a los vehículos correspondientes.
- Seguimiento de Mantenimiento: Lleva un registro del historial de mantenimiento de los vehículos.
- Registro de Combustible: Permite registrar las cargas de combustible y los gastos asociados.
- Monitoreo de combustible: Proporciona datos para visualizar gráficos y estadísticas sobre el consumo de combustible.
- Generación de Reportes: Ofrece la capacidad de generar reportes sobre el uso de los vehículos y otros datos relevantes.
- Gestión de Flotas: Permite crear, modificar y eliminar flotas.
- Administración de Tipos: Permite gestionar los diferentes tipos de vehículos, combustibles y unidades de medida.
- Gestión de Estaciones de Servicio y Depósitos: Ofrece la posibilidad de administrar las estaciones de servicio y los depósitos de la empresa.
- Seguridad y Permisos: Permite administrar usuarios, tipos de usuario y perfiles de permisos.

## Tecnologías Utilizadas
- Ruby on Rails 7.1: El framework principal utilizado para construir la API.
- Ruby 3.2.2: El lenguaje de programación principal.
- PostgreSQL: Como base de datos.
- Doorkeeper: Para la autenticación de usuarios mediante OAuth 2.
- CanCanCan: Para la gestión de roles y permisos.
- Devise: Para la autenticación de usuarios.
- RSpec: Para la realización de pruebas unitarias.
- Docker: Para la contenerización de la aplicación.

## Cómo Empezar
Para empezar a utilizar CtrlFleet-BackEnd, sigue los siguientes pasos:

### Configuración Local
- Clona el repositorio:
```
git clone https://github.com/augustocomeglio/ctrlfleet-backend.git
```
- Instala las dependencias:
```
bundle install
```
- Prepara la base de datos:
```
rails db:create
rails db:migrate
rails db:seed
```
- Inicia el servidor:
```
rails server
```
- Con Docker Construye y levanta los contenedores:
```
docker-compose up --build
```
Prepara la base de datos:
```
docker-compose run web bundle exec rails db:migrate
docker-compose run web bundle exec rails db:seed
```

## Estructura del Proyecto
El proyecto sigue la estructura estándar de una aplicación de Ruby on Rails, con las siguientes carpetas principales:
- app/controllers: Contiene los controladores que manejan las peticiones de la API.
- app/models: Contiene los modelos que representan los datos de la aplicación.
- config/routes.rb: Define las rutas de la API.
- db/migrate: Contiene las migraciones de la base de datos.
- spec/: Contiene las pruebas de la aplicación.

## Endpoints de la API
La API expone los siguientes endpoints principales:
- POST /oauth/token: Autenticación de usuarios.
- GET, POST /api/v1/brands: Gestión de marcas de vehículos.
- GET, POST, PUT, DELETE /api/v1/fleets: Gestión de flotas.
- GET, POST, PUT, DELETE /api/v1/vehicles: Gestión de vehículos.
- GET, POST, PUT, DELETE /api/v1/fuel_records: Gestión de registros de combustible.
- GET, POST, PUT, DELETE /api/v1/users: Gestión de usuarios.
Y muchos más para la gestión de tipos de vehículos, tipos de combustible, etc.

## Contacto
Para soporte o preguntas, por favor contáctanos a través de ctrlfleet@gmail.com.
