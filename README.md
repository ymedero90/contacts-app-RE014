
# Nombre del Proyecto

Contacts App RE014

Este es un proyecto para un proceso de reclutamiento para el rol de Flutter Dev.

## Tabla de Contenidos

- [Nombre del Proyecto](#nombre-del-proyecto)
  - [Tabla de Contenidos](#tabla-de-contenidos)
  - [Requisitos Previos](#requisitos-previos)
  - [Instalación](#instalación)
  - [Arquitectura del Proyecto](#arquitectura-del-proyecto)
  - [Manejadores de Estado](#manejadores-de-estado)
  - [Gestión de la Base de Datos](#gestión-de-la-base-de-datos)
  - [Versiones y Control de Versiones](#versiones-y-control-de-versiones)
  - [Configuración y Dependencias](#configuración-y-dependencias)
  - [Ejecución](#ejecución)
  - [Despliegue](#despliegue)

## Requisitos Previos

- **Flutter**: `Flutter 3.24.0`.
- **Dart**: `Dart 3.5.0`.
- **Otros requisitos**: (Xcode 15.4, Android Studio 2023.3, VS Code 1.92.2).

## Instalación

```bash
git clone https://github.com/ymedero90/contacts-app-RE014
cd contacts-app-RE014
flutter pub get
```

## Arquitectura del Proyecto

Para este proyecto fue utilizada una versión reducida de Clean Architecture orientada a features.
La idea es desaclopar la lógica de la app y lograr una organización del código, cada feature esta separado por Layers(Capas) cada una tiene una responsabilidad única, y la dependencia entre capas se gestión con inyección de dependencias, de esta forma cada capa depende de Interfaces y no de clases específicas garantizando el desacoplamiento. Cada capa también fue dividida en secciones según su función en la capa.

- **Carpetas principales**:
  - **Carpetas principales**:
  - `/lib`: Código fuente de la aplicación.
  - `/lib/common`:
    - `/lib/common/core`: Lógica central.
      - `/lib/common/core/navigation`: Lógica navegación.
    - `/lib/common/domain`: Contenedores de dependencias y manejo de errores.
      - `/lib/common/domain/dependencies_container`: Contenedores de dependencias.
      - `/lib/common/domain/error_handler`: Manejo de errores.
      - `/lib/common/domain/validators.dart`: Validadores de datos.
    - `/lib/common/infraestructura`: Servicios.
      - `/lib/common/infraestructura/local_storage_service`: Servicio de manejo de datos en la BD local.
      - `/lib/common/infraestructura/image_picker_service`: Servicio para el consumo de la cámara y la galleria de fotos del dispositivo.
    - `/lib/common/presentation`: Widgets y elementos compartidos.
  - `/lib/features/auth`: Funcionalidad de autenticación.
    - `/lib/features/auth/application`: Bloc y lógica de negocio para autenticación.
    - `/lib/features/auth/core`: Clases comunes.
    - `/lib/features/auth/domain`: Interfaces de la infraestructura para autenticación.
      - `/lib/features/auth/domain/entities`: Entidades del dominio.
      - `/lib/features/auth/domain/datasources`: Orígenes de datos para autenticación.
      - `/lib/features/auth/domain/repositories`: Repositorios de datos para autenticación.
    - `/lib/features/auth/infrastructure`: Implementación de la infraestructura para autenticación.
      - `/lib/features/auth/infrastructure/dtos`: Data Transfer Object.
      - `/lib/features/auth/infrastructure/datasources`: Orígenes de datos para autenticación.
      - `/lib/features/auth/infrastructure/repositories`: Repositorios de datos para autenticación.
    - `/lib/features/auth/presentation`: Páginas y widgets de la interfaz de usuario relacionadas con la autenticación.
  - `/lib/features/contacts`: Funcionalidad de contactos.
    - Cumple con la misma estructura del feature Auth
  - `/lib/features/users`: Funcionalidad de users.
    - Cumple con la misma estructura del feature Auth
  
- **Diagrama de arquitectura**:
  Presentation -> Application -> Dominio -> Repositories -> Datasources (al obtener los datos este flujo va en dirección contraria)
  La capa de Dominio es el engranaje de la app, el resto de las capas depentes de ella

## Manejadores de Estado

Para controlar los estados y cambios en las vistas, y también separar las responsabilidades de la lógica para la vista fue utilizado uno de los State Management más populares, Bloc.

- **Gestor de estado principal**: `bloc: ^8.1.0`, `flutter_bloc: ^8.1.6`.
- **Cómo se implementa**: La implementación de cada Bloc se realiza en la capa de Application de cada feature, consta de tres archivos principales que contienen la lógica para el Bloc, los States, y los Events. Cada Bloc tiene la implementación de la lógica de negocio asociada a su vista. Entonces son consumidos desde la vista correspondiente la cual va a reaccionar segun los estados lanzados por los eventos del Bloc. De esta manera se garantiza la separación de responsabilidades.

## Gestión de la Base de Datos

Para este test ya que los datos a guardar son simples y pocos fue utilizado Hive como BD local. Hive es una base de datos clave-valor liviana y ultra rápida escrita en Dart puro.

- **Tipo de base de datos**: BD no relacional.
- **Package**: `hive: ^2.2.3`.

## Versiones y Control de Versiones

- **Versionado**: Git, GitHub.
- **Control de versiones**: El proyecto fue realizado en una única rama de Git (`develop`).

## Configuración y Dependencias

- **Archivo `pubspec.yaml`**:
  - bloc: ^8.1.0
  - dartz: ^0.10.1
  - equatable: ^2.0.5
  - flutter_bloc: ^8.1.6
  - get_it: ^7.7.0
  - go_router: ^14.2.3
  - hive: ^2.2.3
  - image_picker: ^1.1.2
  - logger: ^2.4.0
  - path_provider: ^2.1.4
  - permission_handler: ^11.3.1

## Ejecución

Instrucciones para ejecutar la aplicación y realizar pruebas:

```bash
flutter run
```

## Despliegue

Pasos para desplegar la aplicación:

- **Android**: Firma, generación de APK/AAB, etc.
- **iOS**: Configuración de Xcode, distribución en App Store.
