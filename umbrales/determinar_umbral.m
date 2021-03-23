

datos = leer_archivo("umbral_5sps.dat");


% Para sincronizar simbolo.
% Para umbral_10sps = 1e6 + 1;
% Para umbral_5sps  = 1e6;
linea_vertical = 1e6;

figure()
plot(datos(linea_vertical: linea_vertical + 1e3))
datos = datos(linea_vertical: end);

numero_de_muestras   = 1e4;
datos = datos(1: numero_de_muestras);
muestras_por_simbolo = 5;

if muestras_por_simbolo > 1
    datos = integrar(datos, muestras_por_simbolo);
end

restar  = mod(length(datos), 2);
datos   = datos(1: end - restar);
datos   = reshape(datos, 2, length(datos)/2);
unos    = datos(1, :);
ceros   = datos(2, :);

media1 = mean(unos);
media0 = mean(ceros);

granualidad_de_t = 100;
detecciones_erroneas = zeros(1, granualidad_de_t);
posibles_umbrales = linspace(media0, media1, granualidad_de_t);

contador = 1;
for t = posibles_umbrales
    prueba = datos;
    prueba(prueba < t) = 0;
    prueba(prueba > t) = 1;
    unos_estimados  = prueba(1, :);
    ceros_estimados = prueba(2, :);  
    detecciones_erroneas(contador) = sum(unos_estimados ~= 1) + sum(ceros_estimados ~= 0);
    contador = contador + 1;
end

figure()
plot(posibles_umbrales, detecciones_erroneas)

figure()
hold on
hist(unos, 100)
hist(ceros, 100)
xlabel("Amplitud de muestra")
ylabel("Numero de ocurrencias")
legend('Unos', 'Ceros')
hold off
