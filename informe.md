## Lectura y escritura sobre el archivo de llegada
Para la reorganización de los bits recibidos en un formato que sencillo de
interpretar en **GNU/Octave** se utilizón el bloque de 
[Pack K Bits](https://wiki.gnuradio.org/index.php/Pack_K_Bits).

En esta parte se está utilizando un bloque llamado
[HEAD](https://wiki.gnuradio.org/index.php/Head), cuya función es limitar la
cantidad de bits/muestras que pasan hacia cierto bloque. De forma resumida, su
operación consiste en parar el flujo de más datos (ya sean bytes, números
flotantes, números complejos, etc...) luego de que ya hayan pasado a través de
este N de estos datos.
    
## Modulación de constelación
Para llevar a cabo la moduluación BPSK, se utilizó el par de
[modulador](https://wiki.gnuradio.org/index.php/Constellation_Modulator) y
[objeto](https://wiki.gnuradio.org/index.php/Constellation_Object) de
constelación. La operación de estos es la siguiente:
- El **objeto de constelación** se encarga de cargar las configuraciones a ser
  utiliadas por el modulador. En este bloque, los parámetros relevantes son:
  + El mapeo de los símbolos.
  + Los puntos en la constelación.
- El **Modulador de constelación** carga la configuración de los símbolos
  especificada en el bloque de **objeto de constelación**, y a parte de esto,
  requiere que especifiquemos el número de muestras por símbolo que va a generar
  y si deseamos utilizar codificación diferencial o no.

En esta implementación se seleccionó el esquema de modulación BPSK. En esta
parte se mapean los símbolos ~~0 y 1 tomados de los bytes~~ y son mapeados a los
símbolos -1 y 1.  
## Pulse shaping y envío de la señal.
### Pulse shaping
El bloque utilizado para el pulse shaping es un **filtro de respuesta finita** que
utiliza los coeficientes generados por la función[^1]:

>firdes.root_raised_cosine(nfilts, nfilts, 1.0/float(sps), 0.35, 11**sps**nfilts)

y una interpolación de los símbolos generados de un valor de 50[^2].  
### Envío de la señal
Una vez teniendo nuestra señal filtrada con el bloque que le antecede,
~~esta señal es multiplicada por una señal cosenoidal de unos 200kHz para moverla de la banda base~~
es transmitida usando el bloque de de transmisión (Tx) para el LimeSDR.
Este bloque de LimeSDR está configurado con:
- Modalidad de transmisión en **Up-Convertion**.
- Frecuencia para el Up-Convertion de unos 400MHz (este valor es modificable con
  un slider en la interfaz gráfica generada durante la operación del sistema).
- Filtro análogo pasabanda para la transmisión con un ancho de banda de unas 5
  veces la frecuencia de muestreo usada y centrado en la frecuencia del
  Up-Convertion.
- Filtro digital pasabanda para la transmisión con un ancho de banda de una vez
  la frecuencia de muestreo usada y centrado alrededor de la frecuencia de
  transmisión.
  
## Recepción y detección de símbolos
### Recepción de la señal enviada
En esta sección se usa el bloque de recepción (Rx) para el Lime SDR. Este bloque
hace la función de recepción y Down-Convertion, y sus filtros están configurados
de la misma forma que el bloque de transmisión (Tx).
~~Esta la señal más tarde es multiplicada nuevamente por una cosenoidal para llevarla~~
~~a banda base.~~

Con la señal de la salida del +bloque de la multiplicación entre cosenoidal+,
esta es filtrada con un filtro pasabaja para eleminar las señal espúreas que
pueden surgir por los procesos de up y donw convertion y también para eliminar
otras componentes de frecuencias fuera del deseado asociadas a interferencias
del medio.

### Sincronización de Clock y Fase
En este punto del sistema, se busca encontrar el mejor tiempo para muestrear las
señales venideras, lo que terminará maximizando la relación señal a ruído de
cada muestra como también reducirá el efecto de interferencia entre símbolos.

Además de eso, poniéndonos en la situación en la que tenemos un transmisión
entre dos dispositivos, los clock de estos van a comenzar en momentos distintos
y también uno va a terminar corriéndose con respecto al otro.

Para cumplir con las tareas antes mencionadas se utiliza el bloque de
**Polyphase Clock Sync**, que se encarga de llevar a cabo tanto el filtrado por
RRC para llevar nuestra señal que llega desde el transmisor a una filtrada por
RC como la de encontrar en qué momento se debería samplear para tener la máxima
relación señal a ruido.

La estrategia de este bloque consiste en un grupo de filtros de diferencias,
todos desfasados por una cierta cantidad de tiempo y en donde uno de estos
filtros se encuentra muy cerca del momento óptimo para el muestreo
[^3](https://wiki.gnuradio.org/index.php/Guided_Tutorial_PSK_Demodulation).

Para encontrar este desfase de dónde se debería samplear tomando en cuenta los
resultados del **Polyphase Clock Sync** se utiliza un lazo de control de segundo
orden.  
### Decodificación de los símbolos
Haciendo referencia a la sección de modulación de constelación, tenemos la
siguiente situación al momento de la decodificación de los símbollos. Esta
cuestión es el asegurar el mismo mapeo tanto para los símbolos enviados como
para el de los recibidos. Nada de lo que se ha hecho hasta el momento asegura la
consistencia del mapeo a través de las varias fases de nuestro sistema, existe
la posibilidad de que al momento de la recepción se haya sincronizado con una
ambigüedad de 180 grados. Para resolver esto, se optó por la codificación
diferencial desde el momento del mapeo de los símbolos antes de la transmisión. 
### Guardado de los símbolos
Esta parte sí que tiene el diablazo y que hasta el momento sólo tengo
corazonadas.
## Footnotes

[^1]:
Tratar de encontrar la forma de entender qué hace esta función a fondo y desglosar su funcionamiento.
[^2]:
Tratar de encontrar cuál es la razón de la interpolación por 50 y cuantas muestras por símbolo estás usano en estos momentos.
[^3]:
Esta cosa es literalmente un control que sirve para ir constantemente estimando la fase en donde se acerca más a la fase ideal (tiempo de muestreo) para nuestro muestreo.
