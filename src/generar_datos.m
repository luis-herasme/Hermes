pkg load communications

% Cargar imagen
imagen                   = imread("../img/color", "png");
[ Altura Anchura Color ] = size(imagen);

% HEADER: 34 bits
ALTURA    = de2bi(Altura              ,  8, 'left-msb');
ANCHURA   = de2bi(Anchura             ,  8, 'left-msb');
DATA_SIZE = de2bi(length(imagen) * 8  , 24, 'left-msb');

% DATA
DATA         = imagen(:);
data_binaria = de2bi(DATA, 8, 'left-msb');
data_binaria = data_binaria'(:);
preambulo    = [
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
% preambulo    = repmat(preambulo, 1, 10);
datos        = cat(2, preambulo, ALTURA, ANCHURA, DATA_SIZE, data_binaria');
length(datos)

% Guardar en archivo
filename = "datos_preambulo_color";
file     = fopen(filename, "wb");
fwrite(file, datos, "float");
fclose(file);
