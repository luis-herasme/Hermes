pkg load signal
pn = [1 1 1 1 0 0 0 1 0 0 1 1 0 1 0];
datos = leer_archivo("enviar_colo2_h_dsss.dat");
iniciar = 100 + 60 + 1;
datos( iniciar: iniciar + 30 )
des = DSSS_comprimir( datos(iniciar: end)', pn );
des(1 : 10)
