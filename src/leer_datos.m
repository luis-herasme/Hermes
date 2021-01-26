
pkg load signal

%% Leer archivo generado en GNU radio.

filename           = "./recibido"
cuantos_datos_leer = 500e3;
empezar_a_leer     = 0.2e6;

% Cada símbolo contiene 10 muestras, esto se determina
% en GNU radio donde tenemos una variable llamada muestras por símbolo.
muestras_por_simbolo = 5;

% La transmisión no empieza de forma instantánea
% por ende las primeras muestras por lo general son ruido. 
% Por esta razón se ignoran las primeras muestras.

datos = leer_archivo(filename, cuantos_datos_leer, empezar_a_leer);

disp( [ "Cantidad de datos: " num2str(length(datos)) ] );

% % Remover componente constante de los datos.
% desplazamiento = sum(datos) / length(datos)
% datos          = datos - desplazamiento;

% Graficar datos recibidos
figure()
plot(datos(1: 1e3))
title("Datos:")

% % Sincronizacion de trama usando Autocorrelación de secuencia de pseudo ruido.



% Este preámbulo debe ser igual que en generar_datos.m
preambulo = [ 1 1 1 1 0 0 0 1 0 0 1 1 0 1 0 ]';

% En generar_datos.m, cada bit del preámbulo es repetido 4 veces,
% para disminuir la probabilidad de que una secuencia que no es
% el preámbulo sea detectada como tal.
frecuencia_preambulo = 4;
preambulo_repetido = repelem(preambulo, frecuencia_preambulo * muestras_por_simbolo);

% Hacemos que el preámbulo sea NRZ, para realizar 
% una comparación equivalente ya que al remover la componente
% constante de data esta se volvió NRZ.
preambulo_repetido = 2 * preambulo_repetido - 1;

    % %% Calculando la autocorrelación
    % autocorrelacion = zeros(1, length(datos));
    % K = sum(preambulo .* preambulo);

    % for i = 1: length(datos) - length(preambulo_repetido)
    %     comparar = datos(i: i + length(preambulo_repetido) - 1);
    %     autocorrelacion(i) = sum( preambulo_repetido .* comparar ) / K;
    % end

    % % Tomar el segundo valor mas alto de autocorrelacion
    % % Se toma el segundo porque si se dan dos picos de valor maximo
    % % Se tomara el pico mas viejo, lo que significa que el mensaje 
    % % Puede estar incompleto

    % [sortedX, sortedInds] = sort(autocorrelacion(:), 'descend');
    % idx = sortedInds(2);

    % Graficar autocorrelacion
    % figure(2)
    % plot(autocorrelacion)
    % title("Autocorrelacion:")

% Calculando la autocorrelación (MUCHO MÁS RÁPIDO)
[ R, desfases ] = xcorr(datos, preambulo_repetido);
figure()
plot(R)
% [ _, i ]        = max(R);
[ _ ind] = sort(R, 'descend');
idx = ind(2);
idx = desfases(idx)

% Graficar autocorrelacion
% figure(2)
% plot(autocorrelacion)
% title("Autocorrelacion:")

figure()
plot(datos(idx: idx + length(preambulo_repetido) ))
title("Trama de autocorrelacion:")


%% Deteccion.

% Se toma el promedio del vector de pseudo ruido
% para porteriormente utilizarlo como umbral para
% determinar que es un cero y que es un uno

% threshold           = sum( datos (idx: idx + length(preambulo_repetido)) ) / length(preambulo_repetido)
% threshold = 0.0572;
threshold = 0.68;
datos_con_preambulo = datos(idx: end);

if muestras_por_simbolo > 1 
    detectado = deteccion(datos_con_preambulo, muestras_por_simbolo, threshold);
else
    datos_con_preambulo(datos_con_preambulo < threshold) = 0;
    datos_con_preambulo(datos_con_preambulo > threshold) = 1;
    detectado = datos_con_preambulo';
end

% Comparando el preámbulo obtenido de la señal luego de la decodificación 
% con el preámbulo para determinar BER del mismo

preambulo_repetido_en_bits = repelem(preambulo, frecuencia_preambulo);
preambulo_estimado         = detectado(1: length(preambulo_repetido_en_bits));
BER_PREAMBULO              = sum(preambulo_estimado ~= preambulo_repetido_en_bits') / length(preambulo_repetido_en_bits)

% % DSSS
data_sin_preambulo = detectado( length ( preambulo_repetido_en_bits ) + 1 : end ) ; % DEBE SER END !!!! % DEBE SER END !!!! % DEBE SER END !!!! % DEBE SER END !!!! % DEBE SER END !!!! % DEBE SER END !!!! % DEBE SER END !!!! % DEBE SER END !!!! 
size(data_sin_preambulo')
size(preambulo)

Fs = 100;

graficarFFT(datos, Fs, "FFT antes de DSSS.")
comprimida         = DSSS_comprimir(data_sin_preambulo, preambulo);

des_repetida = downsample(comprimida, 3);
graficarFFT(des_repetida, Fs/3, "FFT luego de DSSS.")

%% Decodificar la imagen en siguiendo nuestro estándar de cabecera

data_decodificada = decodificar_hamming_7_4( des_repetida );

% % Decodificar Hamming y mostrar imagen.
recibir_imagen(data_decodificada)

% % Guardar resultados, codificados con Hamming

resultado = "resultado"
file = fopen(resultado, "wb");
fwrite(file, detectado, "float");
fclose(file);

% % Determinar el BER

% Se usa un archivo separado porque se llena la memoria.
% Además de esta forma que almacenado para su posterior estudio.
% BER("enviar_lena128_h.dat", resultado)
