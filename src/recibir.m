function r = recibir(datos_binarios, preambulo)
    pkg load communications
    preambulo_size = length(preambulo)
    cantidad_de_bytes = ceil((length(datos_binarios) - preambulo_size) /8);
    datos_binarios_sin_preambulo = datos_binarios(preambulo_size + 1: end);
    datos_decimal = zeros(1, cantidad_de_bytes);

    cantidad_de_bytes_8 = 8 * cantidad_de_bytes
    datos_binarios_sin_preambulo_size = length(datos_binarios_sin_preambulo)

    for i = 1: cantidad_de_bytes - 1
        inicio = 1 + (i - 1) * 8;
        fin = i * 8;
        byte = datos_binarios_sin_preambulo(inicio: fin);
        decimal = bi2de(byte', 'left-msb');
        datos_decimal(i) = decimal;
    end

    altura = datos_decimal(1)
    anchura = datos_decimal(2)
    altura = 2;
    anchura = 2;

    tamano_de_data_binario = cat(
        2,
        de2bi(datos_decimal(3), 8, 'left-msb'),
        de2bi(datos_decimal(4), 8, 'left-msb'),
        de2bi(datos_decimal(5), 8, 'left-msb')
    );
    % tamano_de_data = bi2de(tamano_de_data_binario, 'left-msb')
    tamano_de_data = 136;

    imagen_decodificada = datos_decimal(6: 6 + altura*anchura*3 - 1)
    imagen_decodificada = reshape(imagen_decodificada, [altura anchura 3]);
    imshow(imagen_decodificada)
end
