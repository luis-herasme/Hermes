pkg load communications

% Cargar imagen
imagen = imread("../img/colo2", "png");

[ Altura Anchura Color ] = size(imagen);

% HEADER: 34 bits
ALTURA    = de2bi(Altura              ,  8, 'left-msb');
ANCHURA   = de2bi(Anchura             ,  8, 'left-msb');
DATA_SIZE = de2bi(length(imagen) * 8  , 24, 'left-msb');

% DATA
DATA = double(imagen(:));
data_binaria = de2bi(DATA, 8, 'left-msb');
data_binaria = data_binaria'(:);
preambulo = [
    1
    1
    1
    1
    0
    1
    0
    0
    1
    0
    0
    1
    0
    1
    1
    1
    0
    1
    0
    1
    1
    1
    0
    1
    1
    1
    0
    0
    0
    1
    0
    1
    0
    0
    1
    1
    0
    1
    0
    1
    0
    0
    0
    1
    1
    1
    0
    1
    1
    0
    0
    0
    1
    0
    0
    1
    1
    0
    1
    1
    1
    0
    0
    1
    1
    0
    1
    1
    0
    1
    0
    1
    0
    1
    0
    0
    0
    1
    0
    0
    1
    0
    0
    1
    1
    0
    1
    0
    1
    1
    0
    1
    0
    1
    0
    0
    0
    1
    0
    0]';
datos = cat(2, preambulo, ALTURA, ANCHURA, DATA_SIZE, data_binaria');
% Sugerencia. Agregar algunos valores en el preámbulo que sólo sean basura
% debido a que se pierden algunos de estos cuando se comienza la transmisión y
% recepción.
datos = cat(2, randi([0,1],1,10e3),preambulo, ALTURA, ANCHURA, DATA_SIZE, data_binaria');

disp("Se guardo la siguiente cantidad de bits: ")
length(datos)

% Guardar en archivo
#{
filename = "datos_preambulo_color";
file = fopen(filename, "wb");
fwrite(file, datos, "float");
fclose(file);
#}

write_uchar_binary(datos,"./datos_preambulo_color") % Esta funcioncita realmente
                                                    % no es la gran cosa, solo
                                                    % estoy escribiendo el
                                                    % vector de
                                                    % datos_preambulo_color con
                                                    % sus elementos en
                                                    % caracteres sin signo.
