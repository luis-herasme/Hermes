function [salida] = codificar_hamming_7_4(entrada)
	numero_de_bloques  = length(entrada) / 4;
	entrada_en_bloques = reshape(entrada, 4, numero_de_bloques)';

	P = [
		0	1	1
		1	0	1
		1	1	0
		1	1	1
	];

    % Matriz generadora G =  [ P I ]
	G = [ P eye(4) ];

	salida = mod(entrada_en_bloques * G, 2);
	salida = salida(:)';
end
