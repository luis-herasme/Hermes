function datos = leer_archivo(filename, cantidad, saltar)
    if nargin == 1
        archivo = fopen(filename, 'rb');
        datos   = fread(archivo, 'float');
        fclose(archivo);
    else 
        archivo = fopen(filename, 'rb');
        datos   = fread(archivo, saltar + cantidad, 'float');
        fclose(archivo);
        datos = datos(saltar + 1: end);
    end
end
