function v = BER_hamming(file_enviado, file_recibido)
    % El archivo generado en generar_datos.m
    tx = leer_archivo(file_enviado);

    % El archivo procesado por leer_datos.m
    % Lee leer_datos.toma el archivo que pasa
    % por GNU radio y genera un vector de bits.
    rx = leer_archivo(file_recibido);

    % Cuando se crean estos archivo se le añaden 100 ceros
    % para separar las tramas.
    tx = tx(101: end);

    % Removiendo el preambulo
    TAMANO_PREAMBULO = 60;

    rx = rx(TAMANO_PREAMBULO + 1: end);
    tx = tx(TAMANO_PREAMBULO + 1: end);

    % Decodificando Hamming
    rx = decodificar_hamming_7_4(rx);
    tx = decodificar_hamming_7_4(tx);

    rx = rx(1: length(tx));
    v = sum(rx ~= tx)/length(tx);
end
