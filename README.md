# TMA2C2025E2 - Sistema de Gestión Airbnb

## 📋 Requisitos

| Componente | Versión | Comando de Verificación |
|------------|---------|-------------------------|
| Java JDK   | 23      | `java --version`        |
| MySQL      | 8.0+    | `mysql --version`       |

## 🗄️ BASE DE DATOS
Ejecutar el archivo `airbnb.sql` ubicado en la carpeta `base_datos` en tu servidor MySQL para crear la base de datos y todas las tablas con datos de prueba.

## ⚙️ CONFIGURACIÓN
Modificar el archivo `application.properties` con tus credenciales de MySQL:

```properties
spring.datasource.username=tu_usuario_mysql
spring.datasource.password=tu_contraseña_mysql
```
## 🚀 EJECUCIÓN
Compilar y ejecutar el proyecto desde tu IDE o con:
``` ./mvnw spring-boot:run ```

## 👥 USUARIOS DISPONIBLES
| Email            | Nombre  | Contraseña | Tipo   |
|------------------|---------|------------|--------|
| carlos@host.com  | Carlos  | 1234       | HOST   |
| lucia@guest.com  | Lucía   | abcd       | GUEST  |
| julian@host.com  | Julián  | asdf       | HOST   |
| maria@guest.com  | María   | zxcv       | GUEST  |
| sofia@guest.com  | Sofía   | qwer       | GUEST  |
