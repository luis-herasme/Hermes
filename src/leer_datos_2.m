
% Leer archivo generado en MATLAB
cuantos_datos_leer = 450000e3;
% test_rec_8 es el que funciona
filename = "test_rec_12";
archivo = fopen(filename, 'rb');
datos = fread(archivo, cuantos_datos_leer, 'short');
datos = datos(100: end);
disp("Cantidad de datos:")
length(datos)
fclose(archivo);

% Graficar datos recibidos
figure(1)
stairs(datos)
title("Datos:")

% Decodificar datos
decodificado = zeros(length(datos), 1)';
for i = 1: length(datos)
    if datos(i) > 2
        decodificado(i) = 1;
    else
        decodificado(i) = 0;
    end
end

% Removemos unas cuantas muestras debido a que tarda tiempo para empezar a recibir
% % inicio  = 50e3;
% % datos   = datos(inicio: end);

% % % Cuanto se repite cada valor (Debe ser igual que en GNU RADIO)
% % interpolation = 10;

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

% preambulo_no_repetido = preambulo;
% preambulo = preambulo - 0.5;
% preambulo = repelem(preambulo, interpolation)';

% Calculando autocorrelacion
tamano_preambulo = length(preambulo);
autocorrelacion = zeros(length(decodificado), 1)';

for i = 1: length(decodificado) - tamano_preambulo
    comparar = decodificado(i: i + tamano_preambulo - 1);
    autocorrelacion(i) = sum( preambulo .* comparar );
end

[_ idx] = max(autocorrelacion);
idx
preambulo_estimado = decodificado(idx: idx + tamano_preambulo - 1);

% Graficar autocorrelacion
figure(2)
plot(autocorrelacion)
title("Autocorrelacion:")

BER_PREAMBULO = 1 - sum(preambulo_estimado == preambulo)/tamano_preambulo
HEADER = decodificado(idx + tamano_preambulo: idx + tamano_preambulo + 40)

% Convertir datos a vector binario
datos_con_preambulo = decodificado(idx: end);

figure(3)
recibir(datos_con_preambulo, preambulo);

% % Sincronizar trama con preambulo
% for i = 1: length(autocorrelacion)
%     if autocorrelacion(i) > 2075
%         datos_con_preambulo = datos(i: end);
%         break;
%     end
% end
