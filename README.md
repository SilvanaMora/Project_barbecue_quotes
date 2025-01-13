# Salesforce App: Presupuesto de Asados

## Descripción del Proyecto

El proyecto Presupuesto de Asados es una solución desarrollada en Salesforce para facilitar la gestión eficiente de eventos relacionados con asados. La aplicación permite registrar y administrar clientes, presupuestos, productos y servicios, al tiempo que automatiza procesos clave como la aprobación, cancelación y evaluación de los eventos. Esta herramienta está diseñada para optimizar el flujo de trabajo, garantizar la precisión en los datos y ofrecer métricas claras para la toma de decisiones estratégicas.

## Objetivos

1. **Evaluar** y registrar presupuestos para eventos de asados.
2. **Automatizar** procesos de aprobación y cancelación.
3. **Organizar** productos y servicios relacionados.
4. **Facilitar** evaluaciones de los eventos realizados.
5. **Analizar** datos mediante informes y cuadros de mando.

## Estructura del Proyecto

### Modelo de Datos

#### Objeto: **Contacto**
- Campos: Nombre, CPF, Teléfono, Fecha de Nacimiento, Correo Electrónico.

#### Objeto: **Presupuesto Asado**
- Campos: Nombre, Cliente, Estado, Inicio, Fin, Valor Total.

#### Objeto: **Partida Presupuestaria**
- Campos: Nombre, Presupuesto Asado, Producto, Cantidad, Valor.

#### Objeto: **Producto2**
- Campos: Nombre, Tipo de Registro, Servicio, Valor, Activo.

#### Objeto: **Evaluación**
- Campos: Nombre, Presupuesto Asado, Puntuación, Observaciones.

### Funcionalidades Clave

#### Reglas Empresariales
1. Los presupuestos requieren CPF del cliente para proceder.
2. Productos no activos no pueden seleccionarse.
3. Un contacto no puede repetirse con el mismo CPF.
4. Cambios automáticos en el estado del presupuesto:
   - **Nuevo** → **En proceso de aprobación**.
   - **Aprobado** → **Programado**.
   - **Rechazado** → **Cancelado**.

#### Procesos Automatizados
- **Aprobación de Presupuestos:** Envío de notificaciones por correo electrónico según el resultado.
- **Cancelación Automática:** Trabajo diario en Apex para cancelar presupuestos no realizados.

#### Componentes y Triggers
- **Evaluación del Evento:** Componente LWC para puntuar asados completados.
- **Cálculo Automático de Valores:** Trigger para calcular valores basados en metadatos personalizados.
- **Validación de Duplicados:** Trigger para evitar productos repetidos en un presupuesto.

### Desarrollo de UI/UX
- Uso de Lightning Pages organizadas y optimizadas.
- Páginas con componentes relevantes dispuestos de manera clara.

## Retos Técnicos

1. **Componente LWC:** Pantalla para puntuar asados completados.
2. **Trigger Apex:** Cálculo de valores según duración del evento y tipo de servicio.
3. **Apex Scheduler/Batch:** Cancelación automática de presupuestos.
4. **Flujos:** Presentación para la aprobación de presupuestos.

## Pruebas y Validación

- **Clases de Prueba:** Cobertura mínima del 75% para todas las funcionalidades.
- **Usuario de Prueba:** 
  - Apellido: Formación.
  - Correo: education@everymind.com.br.
  - Nombre de usuario: [nombre].[apellido]@bestminds.com.bm2022-01.

## Configuración del Proyecto

1. **Requisitos Previos:** Acceso a una organización Salesforce y permisos de administrador.
2. **Importación de Código:**
   - Asegúrate de cargar los metadatos y clases Apex en Developer Console.
3. **Configuración de Objetos:** 
   - Crear objetos personalizados según el modelo de datos.
4. **Implementación de Componentes:** 
   - Subir los componentes LWC y Lightning Pages.
5. **Pruebas:** Ejecutar pruebas unitarias para garantizar la funcionalidad.

## Informes y Métricas

- **Indicadores Clave (KPIs):** Seguimiento de presupuestos, ingresos generados y feedback de clientes.
- **Cuadros de Mando:** Visualización interactiva de métricas principales.

## Contribución

Si tienes preguntas o sugerencias sobre este proyecto, no dudes en escribirme. Estaré encantada de ayudarte o recibir tus comentarios. Puedes contactarme a través del correo electrónico:
---



 
Correo: silvanamorachaves@gmail.com


