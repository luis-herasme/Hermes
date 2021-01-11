# Descripciones relevantes sobre el archivo testing4.grc

Primero que nada, si quieres abrir este archivo debes asegurarte de que
tienes el GNU *Radio Companion* en la versión 3.9.

# Funcionamiento
Lo que esta pasando es lo siguiente:
- Genero datos a través de una fuente de datos aleatoria.
- Mapeo esos datos a 4 símbolos en constelación.
- Aplico un filtro RRC a estos símbolos.
- La multiplico por un coseno de 200k (el doble del ancho de banda que espero a
  usar para mi transmisión de datos).
- Transmito por el LimeSDR.
- Recibo por el LimeSDR.
- Le quito el offset multiplicando por otros 200k.
- Le hago un filtrado pasobajo con frecuencia de corte en 100k (mi ancho de banda esperado).
- Hago una corrección de Clock (revisar el ejemplo de [PSK](https://wiki.gnuradio.org/index.php/Guided_Tutorial_PSK_Demodulation)).
  Este bloque también hace la función de filtrado RRC, así que en este punto tengo mis datos
  filtrados con un RC lo que me da la razón de señal a ruido más alta dentro de
  lo que conocemos.
- Aplico un [Costas Loop](https://wiki.gnuradio.org/index.php/Costas_Loop) para sincronizar las fase (Revisar el ejemplo de PSK).
- Imprimo eso en el diagrama de constelación

# Notas
Tal y como Herasme había mencionado, las antenas usadas trabajan mejor para
cierto rango de frecuencias. Mientras jugaba con algunos parámetros de este
sistema encontré que hay mejor desempeño luego de los 2.7GHz.
