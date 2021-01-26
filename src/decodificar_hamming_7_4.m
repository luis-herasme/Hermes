
function [salida] = decodificar_hamming_7_4(entrada)
	salida = [];

	% Si no es un multiplo de 7 remover valores para que lo sea
	remover = mod(length(entrada), 7);
	entrada = entrada(1: end - remover);
	
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
	sindromes		= mod(entrada_en_bloques * H', 2);

	%% VERSIÓN VIEJA

	% % Determino la posicion del sindrome en la lista de sindromes
	% [ m n ] = size(sindromes);

	% for i = 1: m
	% 	sindrome  = sindromes(i, :);
	% 	row_index = find(ismember(SINDROMES, sindrome, 'rows'))
		
	% 	% Determino que error representa dicho sindrome
	% 	error_detectado = ERRORES(row_index, :);

	% 	% Le sumo el error al mensaje para removerlo
	% 	sin_error = mod(entrada_en_bloques(i, :) + error_detectado, 2);

	% 	% Como es un codigo sistematico solo 
	% 	% extraigo la parte que corresponde al mensaje 
	% 	msg = sin_error( 4: end);
	% 	salida = [salida msg];
	% end

	%% VERSIÓN NUEVA VECTORIZADA (MUCHO MÁS RÁPIDO)

	[ _ idx ]		= find(ismember(sindromes, SINDROMES, 'rows'));
	error_detectado = ERRORES(idx, :);
	sin_error 		= mod(entrada_en_bloques + error_detectado, 2);
	msg 			= sin_error(:, 4: end);

	salida = msg'(:)';
end
