# Proyecto final de comunicaciones digitales, Enero 2021
Asignacion final de la asignatura de comunciaciones digitales de INTEC

## Cosas por hacer con las tramas en el diseño de este sistema de comunicación:
### Cabecera
- [ ] Decidir la información que debemos colocar en la parte de las cabeceras.
  Algunas sugerencias son:
  - Tamaño del archivo completo antes de la transmisión.
  - Indicar la cantidad de bits utilizados para el padding en caso de ser usado.
  - El número de trama que le corresponde (de la forma x/y (x trama de y)), con
    esta cosa podemos mantener un orden.
  - El nombre del archivo, por supuesto.
  - Alguna que otra metadata como la fecha, hora y alguan especie de ID para
    saber de quien vino el asunto.
### Toda la trama
- [ ] Escoger el tipo de codificación que se le van a dar a los bits del paquete
  para implementar algún esquema de codificación que nos permita mitigar la
  corrupción de los datos en su transmisión:
  - ¿Utilizaremos codificación convolucional o de bloque lineal? Cual quiera sea
    el modelo tomado, ¿de qué longitud deberían ser las cadenas de bits a codificar?

### Señales piloto
- [ ] Decisiones a tomar con estas cosas:
  - ¿Vamos a terminar usándolas? de ser así, ¿para qué? La opción más razonable
    que veo hasta el momento es para lo de equalización.
    
### Mediciones del canal para las decisiones correspondientes tasa de transferencia a usar, potencia de transmisión a usar, esquema de modulación a usar, etc...
Esta parte es extremadamente importante porque a partir de acá es que vamos a
sacar todos los parámetros necesarios para todas las cosas correspondientes al
título de esta sección.

- [ ] Medir el canal de transmisión:
  - De ser posible, obtener la respuesta en frecuencia.
  - Obtener los niveles de potencia de ruido de fondo.
  
#### Sugerencias para el canal a utilizar
Aún no he encontrado la manera para hacer el procesamiento en Matlab de las
características del medio. De todas formas, mirando en el analizador de espectro
de GNU radio, he visto que el rango de frecuencias de 980 MHz y 1020MHZ está
vacío. Tengo entendido que los dispositivos inalámbricos caseros tienden a
funcionar en frecuencias superiores a los 2000MHz (2GHz) y las emisoras de radio
no pasan de los 500MHz, por lo que el rango sugerido debería estar libre para
nuestras aplicaciones.
[Waterfall display](imgs/pic-full-210108-1605-26.png)


### Espectro disperso
Piensa ve pensando en algo, xd

*Chequear el apartado b) del encabezado de "Elementos a inclur en el reporte" del documento de la descripción de la asignación*

### Tareas a realizar hasta el momento ordenadas por prioridad hasta el momento
1. Medir las propiedades del canal.
2. Diseñar el esquema de trama.
3. Ingeniárselas con Matlab para conseguir partir los archivos en las tramas deseadas.
