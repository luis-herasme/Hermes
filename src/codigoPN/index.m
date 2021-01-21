secuencia = calcularSecuencia([1 1 1 1], @f)
secuencia = repmat(secuencia, 1, 3);
K = sum(secuencia);
autocorrelacionado = autocorrelacion(secuencia, secuencia)/K;
f = figure( )
plot(autocorrelacionado);
title("PN Autocorrelation Function")
ylabel("Amplitud")
% xlabel("Time")
print(f, "autocorrelation.png")
