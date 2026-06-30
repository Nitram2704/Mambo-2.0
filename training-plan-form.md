# Rediseño de Formulario de Plan de Entrenamiento (Wizard)

## Goal
Transformar el formulario de plan de entrenamiento en un asistente de 5 pasos para recopilar un diagnóstico completo del estilo de vida (entrenamiento, nutrición y sueño).

## Tasks
- [ ] Tarea 1: Añadir controladores y todas las nuevas variables de estado para el diagnóstico en `_AuthPlanPageState`.
  - *Verificar*: El código compila sin errores.
- [ ] Tarea 2: Implementar el Paso 1 (Datos Físicos: Peso, Altura, Edad) con sus validaciones.
  - *Verificar*: Bloquea el paso si hay datos vacíos o fuera de rango.
- [ ] Tarea 3: Implementar el Paso 2 (Experiencia y Preferencias: 4 niveles de rendimiento y selección múltiple de estilos).
  - *Verificar*: Selección funcional de nivel y estilos múltiples.
- [ ] Tarea 4: Implementar el Paso 3 (Ubicación y Equipamiento) con la lógica condicional para el equipamiento en casa.
  - *Verificar*: Solo muestra la lista de equipamiento al elegir "En casa / Al aire libre".
- [ ] Tarea 5: Implementar el Paso 4 (Nutrición y Sueño Detallado).
  - **Nutrición**: Tipo de dieta, número de comidas, tiempo de cocina, hidratación y presupuesto (Económico, Moderado, Premium).
  - **Sueño**: Horas de sueño, calidad de descanso, motivo del límite (responsabilidades, insomnio, hábitos), disruptores múltiples (estrés, pantallas, etc.) y energía diurna.
  - *Verificar*: Muestra las opciones con diseño de chips y botones de opción, manteniendo correctamente el estado.
- [ ] Tarea 6: Implementar el Paso 5 (Planificación y Salud: Objetivo, Días de entreno, Duración, Lesiones).
  - *Verificar*: Selección de objetivo, días múltiples y texto libre de lesiones.
- [ ] Tarea 7: Añadir la barra de progreso superior de 5 pasos y los botones de navegación inferior ("Atrás" / "Siguiente" o "Generar plan").
  - *Verificar*: La navegación fluye correctamente hacia adelante y hacia atrás.
- [ ] Tarea 8: Actualizar la llamada de guardado en el repositorio (`_handleGenerate`) con los nuevos campos de diagnóstico.
  - *Verificar*: Se guardan los datos del mapa completo y redirige a la pantalla de bienvenida.

## Done When
- El formulario está dividido en 5 pasos fluidos con barra de progreso.
- Se capturan y validan todos los campos de entrenamiento, nutrición (incluido presupuesto) y sueño (incluyendo limitación por responsabilidades).
- La aplicación compila y funciona correctamente en el navegador local.
