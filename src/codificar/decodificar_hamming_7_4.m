
function [salida] = decodificar_hamming_7_4(entrada)
	numero_de_bloques  = length(entrada) / 7;
	entrada_en_bloques = reshape(entrada, 7, numero_de_bloques)';

	P = [
		0	1	1
		1	0	1
		1	1	0
		1	1	1
	];

    %  H = [ I Paridad' ]
	H = [ eye(3) P' ];

	% Errores -> Sindromes
	ERRORES = [
		0 0 0 0 0 0 0
		0 0 0 0 0 0 1
		0 0 0 0 0 1 0 
		0 0 0 0 1 0 0
		0 0 0 1 0 0 0
		0 0 1 0 0 0 0
		0 1 0 0 0 0 0
		1 0 0 0 0 0 0
		0 1 0 0 0 0 1
	];

	SINDROMES = [
		0 0 0
		1 1 1
		1 1 0
		1 0 1
		0 1 1
		0 0 1
		0 1 0
		1 0 0
		1 0 1
	];

	% Calculo el sindrome de cada mensaje codificado
	sindromes = mod(entrada_en_bloques * H', 2);

	% Determino la posicion del sindrome en la lista de sindromes
	row_index = find(ismember(SINDROMES, sindromes, 'rows'));

	% Determino que error representa dicho sindrome
	errores_detectados	= ERRORES(row_index, :);
	
	% Le sumo el error al mensaje para removerlo
	sin_error = mod(entrada_en_bloques + errores_detectados, 2);

	% Como es un codigo sistematico solo 
	% extraigo la parte que corresponde al mensaje 
	salida = sin_error(:, 4: end);
end



	% sindromes = []
	% for e = errores'
	% 	simdromes = [sindromes; mod(e' * Ht, 2)];
	% end

	% mensaje -> mensaje codificado
	% mensajes = [
	% 	0 0 0 0
	% 	0 0 0 1
	% 	0 0 1 0
	% 	0 0 1 1
	% 	0 1 0 0
	% 	0 1 0 1
	% 	0 1 1 0
	% 	0 1 1 1
	% 	1 0 0 0
	% 	1 0 0 1
	% 	1 0 1 0
	% 	1 0 1 1
	% 	1 1 0 0
	% 	1 1 0 1
	% 	1 1 1 0
	% 	1 1 1 1
	% ];

	% codificado = []
	% for i = 1: 16
	% 	codificado = [codificado; codificar_hamming_7_4(mensajes(i, :))];
	% end
	% codificado
