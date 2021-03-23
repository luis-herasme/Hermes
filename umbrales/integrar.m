function en_binario = integrar(datos_con_preambulo, muestras_por_simbolo)
    restar              = mod(length(datos_con_preambulo), muestras_por_simbolo);
    datos_con_preambulo = datos_con_preambulo(1: end - restar);
    datos_con_preambulo = reshape(datos_con_preambulo, muestras_por_simbolo, length(datos_con_preambulo)/muestras_por_simbolo);
    en_binario          = sum(datos_con_preambulo);
end