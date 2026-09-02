# 🛵 DomiSmart - Ecosistema Interactivo Mobile

Aplicación móvil multiplataforma desarrollada en **Flutter** e integrada con servicios *serverless* en la nube de **Google Firebase**, diseñada para la gestión, asignación y seguimiento de domicilios en tiempo real para pequeños comercios, clientes y repartidores.

---

## 📋 Tabla de Contenidos
- [Descripción del Proyecto](#-descripción-del-proyecto)
- [Problema y Solución](#-problema-y-solución)
- [Arquitectura y Tecnologías](#-arquitectura-y-tecnologías)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Roles de Usuario](#-roles-de-usuario)
- [Estrategia de Seguridad y Costos](#-estrategia-de-seguridad-y-costos)
- [Instrucciones de Despliegue](#-instrucciones-de-despliegue)
- [Documentación y Presentación](#-documentación-y-presentación)
- [Autor](#-autor)

---

## 🎯 Descripción del Proyecto
DomiSmart optimiza la logística de entregas a nivel local mediante la coordinación en tiempo real entre tres actores clave: **Cliente**, **Comercio** y **Domiciliario**. La plataforma elimina el desorden de canales informales (llamadas/WhatsApp), permitiendo gestionar pedidos desde su creación hasta la entrega final de manera transparente y eficiente.

---

## ❓ Problema y Solución

* **Situación Problema:** En la distribución local de mercancías, muchos comercios pequeños y repartidores independientes gestionan sus envíos manualmente. Esto provoca desorden en las rutas, falta de trazabilidad en las entregas y desconfianza en los clientes al no conocer el estado de sus paquetes.
* **Pregunta Problema:** *¿De qué manera el desarrollo de una aplicación móvil multiplataforma en Flutter, integrada con servicios en la nube de Firebase, permite optimizar el tiempo de asignación y la trazabilidad de los envíos a domicilio en tiempo real?*
* **Objetivo SMART:** Desarrollar una solución móvil multiplataforma (Android/Web) con Flutter y Firebase para reducir en un 40% el tiempo de asignación y registro de domicilios en un plazo de 8 semanas.

---

## 🏗 Arquitectura y Tecnologías

La aplicación sigue una **arquitectura por capas limpia** (Vistas $\rightarrow$ Servicios $\rightarrow$ Modelos $\rightarrow$ Firebase Cloud BaaS).

* **Frontend:** Flutter SDK 3.x (Lenguaje Dart) - Enfoque Multiplataforma / Cross-Platform (Android & Web).
* **Autenticación:** Firebase Authentication (Tokens JWT seguros y manejo asíncrono del estado de sesión).
* **Base de Datos Cloud:** Cloud Firestore (NoSQL orientada a documentos con sincronización y reactividad mediante `Streams`).
* **Control de Versiones:** Git & GitHub.

---

## 📂 Estructura del Proyecto

```text
lib/
├── models/
│   └── order_model.dart          # Modelo de datos de pedidos y parseo desde/hacia Firestore
├── services/
│   ├── auth_service.dart         # Registro, Login, SignOut y gestión de sesión Firebase
│   └── order_service.dart        # Métodos CRUD y Streams en tiempo real para pedidos
├── screens/
│   ├── client/
│   │   ├── client_home_screen.dart # Dashboard del cliente con accesos rápidos
│   │   └── my_orders_screen.dart   # Listado y seguimiento de pedidos del cliente
│   ├── commerce/
│   │   ├── commerce_home_screen.dart # Métricas clave del negocio y total de pedidos
│   │   └── commerce_orders_screen.dart # Gestión y cambio de estado de pedidos
│   ├── delivery/
│   │   ├── delivery_home_screen.dart # Estado de disponibilidad del repartidor
│   │   └── assigned_orders_screen.dart # Gestión de entregas asignadas en ruta
│   ├── home_screen.dart          # Enrutador dinámico que lee el rol desde Firestore
│   ├── login_screen.dart         # Pantalla de inicio de sesión
│   └── register_screen.dart      # Registro con selección de rol (Cliente, Comercio, Domiciliario)
├── main.dart                     # Punto de entrada y StreamBuilder de persistencia de sesión
└── firebase_options.dart         # Configuración automatizada de Firebase

👥 Roles de UsuarioCliente:Visualiza métricas de pedidos activos.Realiza el seguimiento del estado de sus pedidos en tiempo real.Comercio:Recibe alertas de nuevos pedidos recibidos.Administra el flujo del pedido: Pendiente $\rightarrow$ Aceptado $\rightarrow$ Preparando $\rightarrow$ Listo.Domiciliario:Mantiene el control de su disponibilidad.Actualiza la ruta del paquete: En camino $\rightarrow$ Entregado.🔐 Estrategia de Seguridad y CostosSeguridad en Dispositivo y Nube: La app protege el canal de comunicación utilizando HTTPS con cifrado TLS hacia los servidores de Firebase. Maneja autenticación basada en tokens JWT emitidos por Firebase Auth. Las reglas de seguridad configuradas en Cloud Firestore restringen el acceso a los datos según el rol asignado (cliente, domiciliario, comercio).Simulador de Costos de Infraestructura:Google Play Console (Cuenta Desarrollador - Pago Único): $25.00 USDFirebase Cloud Storage & Firestore (Consumo Estimado): $15.00 USDCosto Total Estimado: $40.00 USD (Uso óptimo de un presupuesto asignado de $300 USD).🚀 Instrucciones de DespliegueRequisitos previosFlutter SDK (v3.19.0 o superior)Android Studio / VS CodeEmulador Android o Dispositivo Físico con depuración USB activaPasos para ejecutar localmenteClonar el repositorio:Bashgit clone [https://github.com/lfgallego/domismart-mobile.git](https://github.com/lfgallego/domismart-mobile.git)
cd domismart-mobile/mobile
Instalar dependencias:Bashflutter pub get
Ejecutar la aplicación:Bashflutter run -d android
📄 Documentación y PresentaciónToda la documentación técnica del proyecto y las diapositivas ejecutivas para la sustentación se encuentran almacenadas en el directorio /docs:docs/DomiSmart_Presentacion.pdf - Diapositivas ejecutivas del proyecto.👤 AutorLuis Felipe GallegoCurso: Diseño de Aplicaciones Móviles - Taller ABP