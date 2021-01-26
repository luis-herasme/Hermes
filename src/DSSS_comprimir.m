function esparcida = DSSS_comprimir(original, PN)
    PN = hacerIgualLongitud(PN, length(original));
    esparcida = mod(PN + original, 2);
end
