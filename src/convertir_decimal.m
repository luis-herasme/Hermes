function datos_decimal = convertir_decimal(binario)
    pkg load communications

	% Si no es un multiplo de 7 remover valores para que lo sea
	remover = mod(length(binario), 8);
	binario = binario(1: end - remover);

    cantidad_de_bytes = length(binario) / 8;
    binario = reshape(binario, 8, cantidad_de_bytes)';
    datos_decimal = bi2de(binario, 'left-msb');
end
