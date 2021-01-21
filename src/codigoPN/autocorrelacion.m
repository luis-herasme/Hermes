function v = autocorrelacion(v1, v2)
    for i = 1: length(v1)
        v(i) = sum(v2 .* shift(v1, i));
    end
end
