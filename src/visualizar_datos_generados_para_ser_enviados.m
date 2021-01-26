pkg load signal

% Leer archivo generado en MATLAB
nombre_del_archivo = input("Ingrese el nombre del archivo a visualizar:");
datos              = leer_archivo(nombre_del_archivo);
length(datos)

preambulo      = [ 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 ]';
preambulo_size = length(preambulo) * 4;
espaciado      = 100;
chipRate       = 3;

% Remover padding
datos = datos(espaciado + 1: end);

% Remover ceros
datos = datos(preambulo_size + 1: end);

size(datos)
size(preambulo)

% Remover esparcimiento en frecuencia
datos = DSSS_comprimir(datos', preambulo');
datos = downsample(datos, chipRate);
datos = decodificar_hamming_7_4(datos);
recibir_hamming(datos)
