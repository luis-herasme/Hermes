# Sistema-de-comunicacion-digital-creador-con-radio-definido-por-software

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

