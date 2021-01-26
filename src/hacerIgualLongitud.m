function igual = hacerIgualLongitud(vector, longitud)

    if length(vector) > longitud
        disp("ERROR: length(vector) > logitud")
        return;
    end

    n = ceil(longitud/length(vector));
    vector = repmat(vector, 1, n);
    igual = vector(1: longitud);
end
