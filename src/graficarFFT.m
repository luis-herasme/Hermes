function r = graficarFFT(f, fm, titulo)
    figure()
    % f = f - mean(f);
    w = linspace(0, fm, length(f)) - fm / 2;
    stem(w, abs(fftshift(fft(f))))
    xlabel('Frecuencia (Hz)')
    title(titulo)
end