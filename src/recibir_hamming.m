function r = recibir_hamming(datos_binarios)
    pkg load communications
    % cantidad_de_bytes = ceil((length(datos_binarios)) /8)
    % datos_decimal     = zeros(1, cantidad_de_bytes);
    % cantidad_de_bits  = 8 * cantidad_de_bytes
    datos_decimal = convertir_decimal(datos_binarios);

    % for i = 1: cantidad_de_bytes - 1
    %     inicio = 1 + (i - 1) * 8;
    %     fin = i * 8;
    %     byte = datos_binarios(inicio: fin);
        
    %     decimal = bi2de(byte, 'left-msb');
    %     datos_decimal(i) = decimal;
    % end

    tamano_de_data_binario = cat(
        2,
        de2bi(datos_decimal(3), 8, 'left-msb'),
        de2bi(datos_decimal(4), 8, 'left-msb'),
        de2bi(datos_decimal(5), 8, 'left-msb')
    );

    altura = datos_decimal(1)
    anchura = datos_decimal(2)
    tamano_de_data = bi2de(tamano_de_data_binario, 'left-msb')
    figure()
    imagen_decodificada = datos_decimal(6: 6 + altura * anchura * 3 - 1)';
    imagen_decodificada = reshape(imagen_decodificada, [altura anchura 3]);
    imagen_decodificada = uint8(imagen_decodificada)
    imshow(imagen_decodificada)
end
