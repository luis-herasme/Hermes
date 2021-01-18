function p = buscar_preambulo(datos_binario, preambulo)
    bloque = datos_binario(1: 1 + length(preambulo) - 1)';
    size(bloque)
    size(preambulo)
    for i = 1: length(datos_binario) - length(preambulo)
        bloque = datos_binario(i: i + length(preambulo) - 1)';
        if sum(bloque == preambulo) > 60
            sum(bloque == preambulo)
        end
        if isequal(bloque, preambulo)
            disp("IGUAL: ")
            i
        end
    end
end