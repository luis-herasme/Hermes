
% Leer archivo generado en MATLAB
cuantos_datos_leer = 300e3;
filename           = "datos_preambulo_recibidos_color";
archivo            = fopen(filename, 'rb');
datos              = fread(archivo, cuantos_datos_leer, 'float');
fclose(archivo);

% Removemos unas cuantas muestras debido a que tarda tiempo para empezar a recibir
inicio  = 50e3;
datos   = datos(inicio: end);

% Cuanto se repite cada valor (Debe ser igual que en GNU RADIO)
interpolation = 100;

% Preambulo debe ser igual que en generar_datos.m
preambulo = [
    1
    1
    1
    1
    0
    1
    0
    0
    1
    0
    0
    1
    0
    1
    1
    1
    0
    1
    0
    1
    1
    1
    0
    1
    1
    1
    0
    0
    0
    1
    0
    1
    0
    0
    1
    1
    0
    1
    0
    1
    0
    0
    0
    1
    1
    1
    0
    1
    1
    0
    0
    0
    1
    0
    0
    1
    1
    0
    1
    1
    1
    0
    0
    1
    1
    0
    1
    1
    0
    1
    0
    1
    0
    1
    0
    0
    0
    1
    0
    0
    1
    0
    0
    1
    1
    0
    1
    0
    1
    1
    0
    1
    0
    1
    0
    0
    0
    1
    0
    0]';
% preambulo = repmat(preambulo, 1, 10);
preambulo_no_repetido = preambulo;
preambulo = preambulo - 0.5;
preambulo = repelem(preambulo, interpolation)';

% Calculando autocorrelacion
tamano_preambulo = length(preambulo);
autocorrelacion  = zeros(length(datos), 1)';

for i = 1: length(datos) - tamano_preambulo
    comparar           = datos(i: i + tamano_preambulo - 1);
    autocorrelacion(i) = sum( preambulo .* comparar );
end

% Graficar autocorrelacion
figure(1)
plot(autocorrelacion)
title("AUTOCORRELACION:")

% Sincronizar trama con preambulo
for i = 1: length(autocorrelacion)
    if autocorrelacion(i) > 2075
        datos_con_preambulo = datos(i: end);
        break;
    end
end

% Convertir datos a vector binario
data_enviada_estimada = convertir_a_binario(datos_con_preambulo, interpolation);
buscar_preambulo(data_enviada_estimada, ~preambulo_no_repetido);

% imagen_enviada_estimada = reshape(data_enviada_estimada, 4, 4)';
% imshow(imagen_enviada_estimada)
