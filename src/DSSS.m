function esparcida = DSSS(original, PN, chipRate)
    original = repelem(original, chipRate);
    PN = hacerIgualLongitud(PN, length(original));
    esparcida = mod(PN + original, 2);
end
