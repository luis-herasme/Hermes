function en_binario = deteccion(datos_con_preambulo, muestras_por_simbolo, threshold)
    restar              = mod(length(datos_con_preambulo), muestras_por_simbolo);
    datos_con_preambulo = datos_con_preambulo(1: end - restar);
    datos_con_preambulo = reshape(datos_con_preambulo, muestras_por_simbolo, length(datos_con_preambulo)/muestras_por_simbolo);
    b                   = sum(datos_con_preambulo)/muestras_por_simbolo;
    b(b < threshold)    = 0;
    b(b > threshold)    = 1;
    en_binario = b;
end
    
    % CODIGO VIEJO LENTO ( NO VECTORIZADO )

    % en_binario = zeros(1, ceil( length(datos_con_preambulo) / muestras_por_simbolo ));
    % indices = 1;

    % for i = 1: muestras_por_simbolo: length(datos_con_preambulo) - muestras_por_simbolo
    %     if sum( datos_con_preambulo(i: i + muestras_por_simbolo) ) / muestras_por_simbolo > threshold
    %         en_binario(indices) = 1;
    %     else
    %         en_binario(indices) = 0;
    %     end
    %     indices = indices + 1;
    % end

    % en_binario
