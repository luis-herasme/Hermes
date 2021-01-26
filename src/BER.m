function v = BER(file_enviado, file_recibido)
    % El archivo generado en generar_datos.m
    tx = leer_archivo(file_enviado);

    % El archivo procesado por leer_datos.m
    % Lee leer_datos.toma el archivo que pasa
    % por GNU radio y genera un vector de bits.
    rx = leer_archivo(file_recibido);

    % Cuando se crean estos archivo se le añaden 100 ceros
    % para separar las tramas.
    tx = tx(101: end);
    rx = rx(1: length(tx));

    v = sum(rx ~= tx)/length(tx);
end