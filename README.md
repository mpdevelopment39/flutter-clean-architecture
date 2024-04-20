# flutter_clean_architecture_demo

  A nivel arquitectura he decidido implementar <strong>Clean Architecture</strong> de una manera sencilla con su correspondiente abstracción de capas.

  - <strong>UI/Presentation.</strong> Donde definimos todo lo que tenga que ver con la interfaz de la aplicación, páginas, componentes/widgets, gestión de estados con riverpod...
  - <strong>Domain.</strong> Donde definimos nuestras entidades de dominio que utilizaremos a lo largo de la aplicación así como los repositorios y los managers(casos de uso). He decidido crear la capa de managers para una gestión más cómoda. Si consideramos que el proyecto se hace muy grande podríamos evitar esta agrupación y gestionar directamente los usecases agrupados en carpetas por funcionalidad.
  - <strong>Data.</strong> Donde definimos la implementación de nuestros repositorios (Obtención de datos de backend/apis,bbdd,preferencias locales...), las entidades o modelos de data como las respuestas de dichas fuentes de datos y los mappers para convertir las entidades de data en entidades de dominio que utilizaremos en nuestra app.

  <strong>NOTA:</strong> He decidido no crear una entidad más de abstracción como los datasources con sus implementaciones para mantener el proyecto lo más sencillo posible, pero si nos vieramos en una situación en la cual para obtener datos podemos tener diversas fuentes u origenes como por ejemplo un backend o una bbdd local con información cacheada podríamos tener esta capa y definir en cada momento que datasource o fuente de datos queremos implementar en nuestros repositorios.
  
  Para la escrítura de los comentarios del código suelo utilizar la extensión Better Comments de VS Code ya que resulta muy visual y cómoda a la hora de leer dichos comentarios, ya que nos permite tener diversos formatos.

<h2>Librerías utilizadas para el diseño</h2>

  * [<b>sizer</b>](https://pub.dev/packages/sizer)
    * Para realizar diseño responsive en función de la resolución de cada dispositivo.
  * [<b>lottie</b>](https://pub.dev/packages/lottie)
    * Para mostrar animaciones en formato json.
  * [<b>liquid_swipe</b>](https://pub.dev/packages/liquid_swipe)
    * Para realizar el diseño del carrousel inicial.
  * [<b>flutter_svg</b>](https://pub.dev/packages/flutter_svg)
    * Para poder utilizar recursos vectoriales en formato svg.
  * [<b>animate_do</b>](https://pub.dev/packages/animate_do)
    * Para utilizar animaciones en el diseño.
  * [<b>flutter_staggered_grid_view</b>](https://pub.dev/packages/flutter_staggered_grid_view)
    * Para realizar componente de películas favoritas.
  * [<b>card_swiper</b>](https://pub.dev/packages/card_swiper)
    * Para realizar componente de slider de películas.
  * [<b>device_preview</b>](https://pub.dev/packages/device_preview)
    * Para realizar pruebas de interfaz en cualquier dispositivo.

<h2>Librerías utilizadas para implementación de funcionalidad</h2>

  * [<b>flutter_dotenv</b>](https://pub.dev/packages/flutter_dotenv)
    * Para la gestión de variables de entorno.
  * [<b>dio</b>](https://pub.dev/packages/dio)
    * Para la implementación de peticiones Rest.
  * [<b>flutter_riverpod</b>](https://pub.dev/packages/flutter_riverpod)
    * Como manejador de estados de la aplicación.
  * [<b>get_it</b>](https://pub.dev/packages/get_it)
    * Para la inyección de dependencias.
  * [<b>go_router</b>](https://pub.dev/packages/go_router)
    * Para la navegación y gestión de rutas del proyecto.
  * [<b>isar</b>](https://pub.dev/packages/isar)
    * Como BBDD local en la que almacenar información.
  * [<b>pretty_dio_logger</b>](https://pub.dev/packages/pretty_dio_logger)
    * Para hacer un seguimiento cómodo en consola de los logs de todas las requests realizadas con Dio

<br>
<br>
A continuación se muestran diferentes gifs con el resultado del proyecto:

</p>
<p align="center">
    <img src="/assets/readme/gif1.gif" width="310" height="640">
    <img src="/assets/readme/gif2.gif" width="310" height="640">
    <img src="/assets/readme/gif3.gif" width="310" height="640">
    <img src="/assets/readme/gif4.gif" width="310" height="640">
    <img src="/assets/readme/gif5.gif" width="310" height="640">
    
</p>


<h2>Pasos para ejecutar el proyecto</h2>

 1. Duplicar el archivo .env.template y renombrarlo como .env
 2. Rellenar variables de entorno con sus valores correspondientes
