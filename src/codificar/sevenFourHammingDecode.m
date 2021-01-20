function [output_vector] = sevenFourHammingDecode(entrada)
	numero_de_bloques  = numel(entrada) / 7;
	entrada_en_bloques = reshape(entrada, 7, numero_de_bloques)';

    %   [ I Paridad ]
	decoder_matrix = [
        1	0	0	0	1	1	1	;
        0	1	0	1	0	1	1	;
        0	0	1	1	1	0	1	;
	];

	result_vector = mod(decoder_matrix * entrada_en_bloques', 2)'
	result_vector = result_vector * [4 ; 2 ; 1]

	result_vector(result_vector == 4) = 9;
	result_vector(result_vector == 1) = 11;
	result_vector(result_vector == 3) = 12;

	result_vector = mod(result_vector, 8);

    % adding 1 column at start
	entrada_en_bloques = [ones(size(entrada_en_bloques, 1), 1) entrada_en_bloques];
    result_vector      = [(0: 8: rows(result_vector) * 8 - 1)' result_vector];

    % summing row and column
	result_vector = result_vector * [1 ; 1];

	padded_data = reshape(entrada_en_bloques', numel(entrada_en_bloques), 1)';
	padded_data(result_vector' + 1) = not(padded_data(result_vector' + 1));
	padded_data = reshape(padded_data, 8, numel(padded_data) / 8)';

	padded_data   = padded_data(:, 5: end);
	output_vector = reshape(padded_data', numel(padded_data), 1)';
end
