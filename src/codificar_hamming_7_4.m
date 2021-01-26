function [salida] = codificar_hamming_7_4(entrada)
	salida = [];
	entrada = entrada(:);
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

	%% VERSIÓN VIEJA

	% [m n] = size(entrada_en_bloques);
	% for i = 1: m
	% 	m = entrada_en_bloques(i, :);
	% 	m = mod(m * G, 2);
	% 	salida = [salida m];
	% end
	
	%% VERSIÓN NUEVA VECTORIZADA (MUCHO MÁS RÁPIDO)
	
	m = mod(entrada_en_bloques * G, 2);
	salida = m'(:)';
end
