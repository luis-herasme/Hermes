function igual = hacerIgual(largo, corto)

    if length(corto) > length(largo)
        disp("Error: La logitud del vector corto es mayor a la del vector largo.")
    end

    n = 1;
    for i = 1: length(largo)

        if i > n * length(corto)
            n = n + 1;
        end

        largo(i) = corto(i - (n - 1) * length(corto));

    end

    igual = largo;
end
