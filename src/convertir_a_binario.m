function en_binario = convertir_a_binario(datos, interpolation)
    cantidad_de_bits = ceil(length(datos)/interpolation);
    data_enviada_estimada = zeros(cantidad_de_bits, 1);

    for i = 1: cantidad_de_bits - 1    
        inicio = 1 + interpolation * (i - 1);
        fin = interpolation * i;
        promedio = sum( datos(inicio: fin) );

        if promedio < 0
            data_enviada_estimada(i) = 0;
        else
            data_enviada_estimada(i) = 1;
        end
    end

    en_binario = data_enviada_estimada;
end