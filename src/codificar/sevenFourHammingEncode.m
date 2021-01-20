function [salida] = sevenFourHammingEncode(entrada)
	numero_de_bloques  = length(entrada) / 4;
	entrada_en_bloques = reshape(entrada, 4, numero_de_bloques)';
        
    %   [ Paridad I ]
	matriz_generadora = [
        0	1	1	1	0	0	0	;
        1	0	1	0	1	0	0	;
        1	1	0	0	0	1	0	;
        1	1	1	0	0	0	1	;
	];

	salida = mod(entrada_en_bloques * matriz_generadora, 2);
	salida = salida(:)';
end
