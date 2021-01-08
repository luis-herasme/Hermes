% Cargando paquete
pkg load communications
data = [ 1 0 1 0 ]

% Generando señal BPSK
modulation = 2
y = pskmod(data, modulation)
plot(real(y), imag(y), 'o')
