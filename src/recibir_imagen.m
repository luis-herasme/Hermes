function r = recibir_imagen(datos_binarios)
    pkg load communications

    datos_decimal = convertir_decimal(datos_binarios);

    tamano_de_data_binario = cat(
        2,
        de2bi(datos_decimal(3), 8, 'left-msb'),
        de2bi(datos_decimal(4), 8, 'left-msb'),
        de2bi(datos_decimal(5), 8, 'left-msb')
    );

    altura         = datos_decimal(1)
    anchura        = datos_decimal(2)
    tamano_de_data = bi2de(tamano_de_data_binario, 'left-msb')

    figure()
    imagen_decodificada = datos_decimal(6: 6 + altura * anchura * 3 - 1)';
    imagen_decodificada = reshape(imagen_decodificada, [altura anchura 3]);
    imagen_decodificada = uint8(imagen_decodificada);
    imshow(imagen_decodificada)
end
