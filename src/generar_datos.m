function generar_datos = generar_datos(ruta_fuente)
    pkg load communications

    % Cargar imagen
    % img_nombre = "../img/img3"
    % imagen = imread(img_nombre, "png");
    imagen = imread(ruta_fuente, "png");

    aplicarDSSS = 1
    chipRate = 3;

    [ Altura Anchura Color ] = size(imagen);

    % HEADER: 40 bits
    ALTURA    = de2bi(Altura              ,  8, 'left-msb');
    ANCHURA   = de2bi(Anchura             ,  8, 'left-msb');
    DATA_SIZE = de2bi(length(imagen) * 8  , 24, 'left-msb');

    % DATA
    DATA = double(imagen(:));
    data_binaria = de2bi(DATA, 8, 'left-msb');
    data_binaria = data_binaria'(:);

    % % Codificacion
    data_binaria = codificar_hamming_7_4(data_binaria);
    ALTURA = codificar_hamming_7_4(ALTURA);
    ANCHURA = codificar_hamming_7_4(ANCHURA);
    DATA_SIZE = codificar_hamming_7_4(DATA_SIZE);

    preambulo = [1 1 1 1 0 0 0 1 0 0 1 1 0 1 0];

    % Se expande el preambulo para disminuir la 
    % probabilidad de que haya un error de deteccion.
    datos      = cat(2, ALTURA, ANCHURA, DATA_SIZE, data_binaria);


    if aplicarDSSS == 1
        esparcida  = DSSS(datos, preambulo, chipRate);
    else
        esparcida  = datos;
    end

    preambulo4 = repelem(preambulo, 4);
    datos      = cat(2, zeros(1, 100), preambulo4, esparcida);

    disp("Se guardo la siguiente cantidad de bits: ")
    length(datos)

    % Guardar en archivo
    filename = "datos_enviar"
    file = fopen(filename, "wb");
    fwrite(file, datos, "float");
    fclose(file);
end