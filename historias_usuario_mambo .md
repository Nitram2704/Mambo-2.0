# Historias de Usuario — Sistema Mambo

> **Total:** 23 historias de usuario | 🔴 8 Alta prioridad | 🟡 9 Media prioridad | 🔵 6 Baja prioridad

---

## 🔐 Módulo 1: Autenticación y Acceso

### HU-01 — Inicio de sesión
**Prioridad:** 🔴 Alta | **Puntos:** 3

**Como** usuario,  
**quiero** ingresar mis credenciales al sistema,  
**para** acceder de forma segura a las funcionalidades disponibles.

**Criterios de aceptación:**
- El sistema valida usuario y contraseña ingresados.
- Si las credenciales son incorrectas, muestra mensaje de error.
- Si son correctas, redirige al módulo principal.
- El sistema bloquea el acceso tras N intentos fallidos.

---

### HU-02 — Registro de usuario
**Prioridad:** 🔴 Alta | **Puntos:** 2

**Como** administrador,  
**quiero** registrar nuevos usuarios en el sistema,  
**para** controlar quién tiene acceso a la plataforma.

**Criterios de aceptación:**
- Permite crear cuenta con nombre, correo y contraseña.
- Valida que los campos obligatorios estén completos.
- Confirma el registro exitoso con mensaje al usuario.
- No permite registrar un correo ya existente.

---

### HU-03 — Recuperación de contraseña
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** usuario,  
**quiero** recuperar mi contraseña olvidada,  
**para** no perder el acceso al sistema.

**Criterios de aceptación:**
- El sistema ofrece flujo de recuperación manual o automático (código de barras).
- Permite ingresar nuevo código de acceso.
- Confirma el cambio exitoso antes de redirigir al login.

---

## 👥 Módulo 2: Gestión de Grupos y Estudiantes

### HU-04 — Crear grupo
**Prioridad:** 🔴 Alta | **Puntos:** 2

**Como** instructor,  
**quiero** crear grupos de estudiantes,  
**para** organizar las clases de baile por nivel o modalidad.

**Criterios de aceptación:**
- Permite crear un grupo nuevo con nombre y configuración básica.
- El sistema confirma la creación con mensaje de éxito.
- El grupo queda disponible para asignar alumnos.

---

### HU-05 — Asignar alumno a grupo
**Prioridad:** 🔴 Alta | **Puntos:** 2

**Como** instructor,  
**quiero** agregar alumnos a un grupo existente,  
**para** gestionar la matrícula de cada clase.

**Criterios de aceptación:**
- Permite buscar alumno por nombre o código.
- Asigna el alumno al grupo seleccionado.
- Confirma la asignación exitosa.
- Muestra listado actualizado del grupo.

---

### HU-06 — Crear matrícula de estudiante
**Prioridad:** 🟡 Media | **Puntos:** 3

**Como** administrador,  
**quiero** registrar la matrícula de un estudiante,  
**para** formalizar su inscripción en el sistema.

**Criterios de aceptación:**
- Registra datos personales del estudiante.
- Asocia al estudiante al grupo correspondiente.
- Permite volver al listado general tras el registro.
- Genera un número o código de matrícula único.

---

### HU-07 — Registrar asistencia
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** instructor,  
**quiero** registrar la asistencia de los alumnos,  
**para** llevar control de presencia por sesión.

**Criterios de aceptación:**
- Muestra lista de alumnos del grupo activo.
- Permite marcar cada alumno como presente o ausente.
- Guarda el registro al confirmar.
- Refleja fecha y hora de la sesión automáticamente.

---

### HU-08 — Solicitar ayuda
**Prioridad:** 🔵 Baja | **Puntos:** 1

**Como** usuario,  
**quiero** solicitar ayuda desde el módulo de grupos,  
**para** resolver dudas durante el proceso de gestión.

**Criterios de aceptación:**
- Existe opción de ayuda accesible dentro del flujo de grupos.
- Muestra guía o contacto de soporte disponible.

---

## 📋 Módulo 3: Plan de Clases y Formularios

### HU-09 — Crear plan de clase
**Prioridad:** 🔴 Alta | **Puntos:** 3

**Como** instructor,  
**quiero** crear un plan de clase,  
**para** estructurar el contenido y objetivos de mis sesiones.

**Criterios de aceptación:**
- Permite ingresar formulario de planificación con campos de contenido y objetivos.
- Se guarda el plan correctamente en el sistema.
- El plan queda disponible para asociar alumnos.
- Permite editar el plan antes de ejecutarlo.

---

### HU-10 — Registrar alumnos en plan
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** instructor,  
**quiero** agregar alumnos al plan de clase,  
**para** definir quiénes participarán en cada sesión planificada.

**Criterios de aceptación:**
- Permite asociar alumnos existentes al plan de clase activo.
- Muestra confirmación de alumnos registrados en el plan.
- Permite quitar alumnos del plan si es necesario.

---

## 🏋️ Módulo 4: Rutinas y Ejercicios

### HU-11 — Crear rutina
**Prioridad:** 🔴 Alta | **Puntos:** 2

**Como** instructor,  
**quiero** crear rutinas de ejercicios,  
**para** estructurar las sesiones de entrenamiento de mis clases.

**Criterios de aceptación:**
- Permite crear rutina con nombre y descripción.
- Se guardan los datos correctamente.
- La rutina queda disponible para ser ejecutada o editada.

---

### HU-12 — Iniciar rutina
**Prioridad:** 🔴 Alta | **Puntos:** 3

**Como** instructor,  
**quiero** iniciar una rutina,  
**para** ejecutar los ejercicios programados en secuencia durante la clase.

**Criterios de aceptación:**
- Inicia la rutina seleccionada mostrando el primer ejercicio.
- Muestra ejercicios en el orden definido.
- Permite avanzar al siguiente ejercicio manualmente.
- Registra el inicio con fecha y hora.

---

### HU-13 — Seleccionar ejercicios
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** instructor,  
**quiero** seleccionar ejercicios dentro de una rutina,  
**para** personalizar la sesión según las necesidades del grupo.

**Criterios de aceptación:**
- Lista todos los ejercicios disponibles en el sistema.
- Permite elegir cuáles incluir en la rutina activa.
- Guarda la selección y refleja los cambios.

---

### HU-14 — Quedarme con selección de ejercicios
**Prioridad:** 🟡 Media | **Puntos:** 1

**Como** instructor,  
**quiero** guardar temporalmente la selección de ejercicios,  
**para** continuar la configuración de la rutina en otro momento.

**Criterios de aceptación:**
- El sistema guarda el estado actual de la selección.
- Al regresar, muestra los ejercicios previamente seleccionados.

---

### HU-15 — Pulsar / Pausar rutina
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** instructor,  
**quiero** pausar o controlar el ritmo de la rutina durante su ejecución,  
**para** adaptar el tiempo según el ritmo de la clase.

**Criterios de aceptación:**
- Permite pausar y reanudar la rutina en cualquier momento.
- Mantiene el estado actual (ejercicio en curso, tiempo transcurrido).
- No pierde el progreso al pausar.

---

### HU-16 — Guardar rutina en curso
**Prioridad:** 🔵 Baja | **Puntos:** 1

**Como** instructor,  
**quiero** guardar el progreso de la rutina mientras está en curso,  
**para** poder retomarlo en una sesión posterior.

**Criterios de aceptación:**
- Persiste el avance de la rutina activa al salir del módulo.
- Al regresar, permite continuar desde el punto guardado.

---

### HU-17 — Terminar rutina
**Prioridad:** 🔵 Baja | **Puntos:** 2

**Como** instructor,  
**quiero** finalizar y registrar una rutina completada,  
**para** llevar historial de sesiones realizadas.

**Criterios de aceptación:**
- Finaliza la rutina y marca todos los ejercicios como completados.
- Registra fecha, hora de fin y duración total.
- Muestra resumen de la sesión al instructor.

---

## 💰 Módulo 5: Tarifas y Pagos

### HU-18 — Crear tarifa
**Prioridad:** 🔴 Alta | **Puntos:** 2

**Como** administrador,  
**quiero** crear tarifas de servicios,  
**para** definir los precios de los diferentes servicios ofrecidos por la academia.

**Criterios de aceptación:**
- Permite ingresar nombre, valor y descripción de la tarifa.
- Valida que el valor ingresado sea numérico y positivo.
- Se guarda correctamente en el sistema.

---

### HU-19 — Registrar tarifa asignada
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** administrador,  
**quiero** registrar y asociar una tarifa a un grupo o servicio específico,  
**para** gestionar los cobros de forma organizada.

**Criterios de aceptación:**
- Asocia una tarifa existente a un concepto o grupo.
- Registra la asociación en el sistema.
- Permite editar o actualizar la asignación.

---

### HU-20 — Guardar tarifa
**Prioridad:** 🔵 Baja | **Puntos:** 1

**Como** administrador,  
**quiero** guardar los cambios realizados a una tarifa,  
**para** mantener la información de precios actualizada.

**Criterios de aceptación:**
- Persiste todos los datos de tarifa ingresados o modificados.
- Muestra confirmación de guardado exitoso.

---

## 📊 Módulo 6: Gastos y Categorías

### HU-21 — Categorizar gastos
**Prioridad:** 🟡 Media | **Puntos:** 2

**Como** administrador,  
**quiero** clasificar los gastos por categoría,  
**para** analizar los egresos del negocio de forma estructurada.

**Criterios de aceptación:**
- Permite seleccionar o crear categorías de gasto.
- Asigna la categoría al registro de gasto correspondiente.
- Permite filtrar gastos por categoría en reportes.

---

### HU-22 — Ingresar gasto desde base de datos
**Prioridad:** 🟡 Media | **Puntos:** 3

**Como** administrador,  
**quiero** ingresar gastos usando datos ya almacenados,  
**para** agilizar el registro sin duplicar información.

**Criterios de aceptación:**
- Permite seleccionar proveedor o concepto desde la base de datos.
- Calcula totales o subtotales automáticamente según selección.
- Asocia el gasto al período contable correspondiente.

---

### HU-23 — Ingresar gasto manualmente
**Prioridad:** 🔵 Baja | **Puntos:** 2

**Como** administrador,  
**quiero** registrar un gasto de forma manual,  
**para** cubrir casos donde el proveedor o concepto no existe en la base de datos.

**Criterios de aceptación:**
- Formulario libre con campos: descripción, monto, fecha y categoría.
- Valida que monto y fecha sean datos válidos.
- Guarda el gasto en el sistema correctamente.

---

### HU-24 — Ver soluciones alternativas de gasto
**Prioridad:** 🔵 Baja | **Puntos:** 1

**Como** administrador,  
**quiero** explorar alternativas para categorías de gasto frecuentes,  
**para** optimizar los costos operativos de la academia.

**Criterios de aceptación:**
- El sistema sugiere o muestra alternativas para los conceptos de gasto más recurrentes.
- Permite comparar opciones antes de registrar el gasto final.

---

## Resumen de Prioridades

| Prioridad | Cantidad | Historias |
|-----------|----------|-----------|
| 🔴 Alta | 8 | HU-01, HU-02, HU-04, HU-05, HU-09, HU-11, HU-12, HU-18 |
| 🟡 Media | 9 | HU-03, HU-06, HU-07, HU-10, HU-13, HU-14, HU-15, HU-19, HU-21, HU-22 |
| 🔵 Baja | 6 | HU-08, HU-16, HU-17, HU-20, HU-23, HU-24 |
| **Total** | **23** | |

## Tabla de Estimación

| ID | Historia | Módulo | Prioridad | Puntos |
|----|----------|--------|-----------|--------|
| HU-01 | Inicio de sesión | Autenticación | 🔴 Alta | 3 |
| HU-02 | Registro de usuario | Autenticación | 🔴 Alta | 2 |
| HU-03 | Recuperación de contraseña | Autenticación | 🟡 Media | 2 |
| HU-04 | Crear grupo | Grupos | 🔴 Alta | 2 |
| HU-05 | Asignar alumno a grupo | Grupos | 🔴 Alta | 2 |
| HU-06 | Crear matrícula | Grupos | 🟡 Media | 3 |
| HU-07 | Registrar asistencia | Grupos | 🟡 Media | 2 |
| HU-08 | Solicitar ayuda | Grupos | 🔵 Baja | 1 |
| HU-09 | Crear plan de clase | Plan | 🔴 Alta | 3 |
| HU-10 | Registrar alumnos en plan | Plan | 🟡 Media | 2 |
| HU-11 | Crear rutina | Rutinas | 🔴 Alta | 2 |
| HU-12 | Iniciar rutina | Rutinas | 🔴 Alta | 3 |
| HU-13 | Seleccionar ejercicios | Rutinas | 🟡 Media | 2 |
| HU-14 | Guardar selección | Rutinas | 🟡 Media | 1 |
| HU-15 | Pausar rutina | Rutinas | 🟡 Media | 2 |
| HU-16 | Guardar rutina en curso | Rutinas | 🔵 Baja | 1 |
| HU-17 | Terminar rutina | Rutinas | 🔵 Baja | 2 |
| HU-18 | Crear tarifa | Tarifas | 🔴 Alta | 2 |
| HU-19 | Registrar tarifa asignada | Tarifas | 🟡 Media | 2 |
| HU-20 | Guardar tarifa | Tarifas | 🔵 Baja | 1 |
| HU-21 | Categorizar gastos | Gastos | 🟡 Media | 2 |
| HU-22 | Ingresar gasto desde BD | Gastos | 🟡 Media | 3 |
| HU-23 | Ingresar gasto manual | Gastos | 🔵 Baja | 2 |
| HU-24 | Ver alternativas de gasto | Gastos | 🔵 Baja | 1 |
| | | | **Total** | **46 pts** |
