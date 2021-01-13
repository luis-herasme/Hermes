pkg load signal;
pkg load mapping;
pkg load communications;


%%% Procesamiento de la señal para su envío
sfps = 30; % Esta es la frecuencia de muestreo por símbolo. Dígase, la cantidad
          % de muestras que se toma por símbolo.
          % El nombre puede confundir mucho! esto es la cantidad de muestras que
          % hay por cada símbolo, no la frecuencia de muestreo per sé. La
          % frecuencia de muestreo a la que estamos acostumbrados se calcula de la forma
          % sfps*f/n_ciclos

%% Generación de los datos a transmitir tomados en el tiempo.
% Generando algunos bits aleatorios para las pruebas.
bits = randi([0,1],1,120); % Estos bits pueden ser perfectamente intercambiados
                           % por la información binaria que le corresponde a
                           % cada uno de ¿los pixeles de información? para tu
                           % imagen, sólo procura poner las cosas en el formato
                           % adecuado antes de.
M = 2; %Numero de bits que voy a tomar
data = bi2de(reshape(bits,M,[])',"left-msb"); % Data en forma de simbolos que
                                              % corresponden a pares de bits.

% Generando las fases a usar para la transmision de estos símbolos
fase = data;
fase(fase == 0) = 0;
fase(fase == 1) = pi/2;
fase(fase == 2) = pi;
fase(fase == 3) = 3*pi/2;

% Generación de las amplitudes para la transmision de estos símbolos
amplitud = data;
A1 = 1.1;
amplitud(amplitud == 0) = A1;
amplitud(amplitud == 1) = A1;
amplitud(amplitud == 2) = A1;
amplitud(amplitud == 3) = A1;

% Generación de los pares de frecuencia y amplitud a utilizar para la
% transmision de los simbolos
sd = []; % El nombre de sd es de Sampled Data. Son basicamente los simbolos que
         % van del 0-3 repetidos en corridas de la longitud especificada en sfps
phi = [];
A = [];
for ii=1:length(data)
  for jj=1:1:sfps
    sd = [sd data(ii)];
    A = [A amplitud(ii)];
    phi = [phi fase(ii)];
  end
end

%% Parámetros del carrier (función en donde está montada la información que
%% quiero transmitir)
n_ciclos = 1; % Esta cosa es cuantas veces quiero que haya oscilaciones
              % completas antes de que se cambie el símbolo
f = 1000;
t_symb = (n_ciclos/f);
t = t_symb/sfps:t_symb/sfps:(length(data)*t_symb);

% Función de prueba
omega = 2*pi*f;
s = A.*cos(omega*t + phi);
write_float_binary(s,"~/file_tests/test");



%% Pulse Shaping #: Esta parte podrías tomarla o quitarla como se quiera.
%% Después de todo se puede modular con Root Cosine dentro de GNU Radio.
Fs = sfps*f/n_ciclos
Fd = 1/t_symb % Tasa de símbolo (setear luego de codificar tus datos en PSK o lo
              % que sea que uses)

% Generación del pulse shaping
type_flag = "sqrt"; % Tipo de filtro RC a usar
r = 0.35; % Roll-off factor
[num,den] = rcosine(Fd,Fs,type_flag,r);
codificacion_rrc = filter(num,den,s);

% Escribiendo la información ya procesada en un archivo binario que GNU Radio
% puede entender.
write_float_binary(codificacion_rrc,"~/file_tests/test_rrc");

% Ilustración de la información usada
%plot(t,s);
%axis([0 10/f]);
%print -dpng "./psk_rrc.png";
