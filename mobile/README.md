# 🚀 DomiSmart - Ecosistema Móvil de Domicilios en Tiempo Real

> Solución tecnológica en la nube desarrollada con **Flutter** y **Firebase Cloud Infrastructure** para la gestión eficiente de pedidos entre clientes, domiciliarios y comercios.

---

## 📌 1. Descripción del Problema
En el sector de entregas locales, la falta de herramientas ligeras y sincronizadas dificulta el seguimiento de pedidos en tiempo real. **DomiSmart** resuelve este problema mediante una aplicación móvil multiplataforma que centraliza la autenticación, la gestión de roles y la actualización de datos instantánea desde la nube.

---

## 🏗️ 2. Arquitectura de la Solución

El proyecto sigue una arquitectura **Serverless / BaaS (Backend as a Service)** limpia y modular:

* **Frontend (Cliente Móvil):** Flutter (Android / Web) utilizando el patrón de arquitectura por capas (UI, Services, Models).
* **Backend Cloud (Firebase):**
  * **Firebase Authentication:** Gestión segura de identidades (Email/Password y Tokens JWT).
  * **Cloud Firestore:** Base de datos NoSQL en tiempo real para perfiles y pedidos.
* **Seguridad:** Comunicaciones encriptadas vía TLS/HTTPS y Reglas de Seguridad en la base de datos para control de acceso basado en roles (`cliente`, `domiciliario`, `comercio`).

---

## 🛠️ 3. Tecnologías Utilizadas

* **Lenguaje:** Dart 3.x
* **Framework:** Flutter 3.x
* **Nube & BaaS:** Firebase (Core, Auth, Firestore)
* **Gestión de Estado:** `StreamBuilder` & `StatefulWidget`
* **Control de Versiones:** Git & GitHub

---

## 🚀 4. Instrucciones de Instalación y Despliegue

### Requisitos Previos
* Flutter SDK instalado (`flutter doctor`).
* Emulador Android o dispositivo físico conectado.

### Pasos de Ejecución
1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/lfgallego/domismart-mobile.git
   cd domismart-mobile/mobile