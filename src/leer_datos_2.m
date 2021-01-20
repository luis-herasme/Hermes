
% Leer archivo generado en MATLAB
cuantos_datos_leer = 300e3;
filename           = "test_rec_3";
archivo            = fopen(filename, 'rb');
datos              = fread(archivo, cuantos_datos_leer, 'short');
fclose(archivo);

figure(1)
% datos = 1e40*datos;
stairs(datos)

decodificado = zeros(length(datos), 1)';

for i = 1: length(datos)
    if datos(i) > 500
        decodificado(i) = 1;
    else
        decodificado(i) = 0;
    end
end



% % Removemos unas cuantas muestras debido a que tarda tiempo para empezar a recibir
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
% % preambulo = repmat(preambulo, 1, 10);
% preambulo_no_repetido = preambulo;
% preambulo = preambulo - 0.5;
% preambulo = repelem(preambulo, interpolation)';

% % Calculando autocorrelacion
tamano_preambulo = length(preambulo);
autocorrelacion  = zeros(length(decodificado), 1)';

for i = 1: length(decodificado) - tamano_preambulo
    comparar           = decodificado(i: i + tamano_preambulo - 1);
    autocorrelacion(i) = sum( preambulo .* comparar );
end

[_ idx] = max(autocorrelacion);
preambulo_estimado = decodificado(idx: idx + tamano_preambulo - 1);

% Graficar autocorrelacion

figure(2)
plot(autocorrelacion)
title("AUTOCORRELACION:")

BER_PREAMBULO = sum(preambulo_estimado == preambulo)/tamano_preambulo


HEADER = decodificado(idx + tamano_preambulo: idx + tamano_preambulo + 40)
% % Sincronizar trama con preambulo
% for i = 1: length(autocorrelacion)
%     if autocorrelacion(i) > 2075
%         datos_con_preambulo = datos(i: end);
%         break;
%     end
% end

% % Convertir datos a vector binario
datos_con_preambulo = decodificado(idx: end);
recibir(datos_con_preambulo, preambulo);
% data_enviada_estimada = convertir_a_binario(datos_con_preambulo, interpolation);
% buscar_preambulo(data_enviada_estimada, preambulo_no_repetido);

% % imagen_enviada_estimada = reshape(data_enviada_estimada, 4, 4)';
% % imshow(imagen_enviada_estimada)
