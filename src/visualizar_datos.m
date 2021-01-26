
% Leer archivo generado en MATLAB
filename = "./enviar_nombres_h.dat"
archivo = fopen(filename, 'rb');
datos = fread(archivo, 5000, 'float');
fclose(archivo);

preambulo = [ 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 ]';
preambulo_size = length(preambulo) * 4;
espaciado = 100;

decodificado = decodificar_hamming_7_4(datos(preambulo_size + espaciado + 1: end));
decodificado(1: 40)
recibir_hamming(decodificado)