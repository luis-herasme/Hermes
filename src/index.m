[FNAME, FPATH, FLTIDX] = uigetfile ()

% Generar datos
ruta_fuente = [FPATH, FNAME]
generar_datos (ruta_fuente)
system("esquema.grc")
