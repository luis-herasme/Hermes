pkg load communications
DATA = [ 1 2 3 ];
data_binaria = de2bi(DATA, 8, 'left-msb')
data_binaria = data_binaria'(:)'
data_binaria_codificada   = codificar_hamming_7_4(data_binaria)
data_binaria_decodificada = decodificar_hamming_7_4(data_binaria_codificada)
convertir_decimal(data_binaria_decodificada)
