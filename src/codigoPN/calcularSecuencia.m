function resultante = calcularSecuencia(estadoInicial, f)
    resultante = [];
    estado = estadoInicial;

    resultante = [resultante estado(length(estado))];
    estado = f(estado);

    while ~isequal(estado, estadoInicial)
        resultante = [resultante estado(length(estado))];
        estado = f(estado);
    end
end 
