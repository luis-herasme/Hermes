sinProcesar = {
    "./pruebas/img1",
    "./pruebas/img2",
    "./pruebas/img3",
    "./pruebas/img1_dsss",
    "./pruebas/img2_dsss",
    "./pruebas/img3_dsss",
};

procesado = {
    "./procesado/img1",
    "./procesado/img2",
    "./procesado/img3",
    "./procesado/img1_dsss",
    "./procesado/img2_dsss",
    "./procesado/img3_dsss",
};

for i = 1: 6
    sinProcesar{i}
    BER(sinProcesar{i}, procesado{i})
end
