F_errores_1=figure;
F_CA50_tr=figure;
F_CA50_val=figure;
F_errores_21=figure;
F_rend_tr=figure;
F_rend_val=figure;
F_errores_22=figure;
F_NOx_tr=figure;
F_NOx_val=figure;

figure(F_errores_1);
plot(Ev1,'DisplayName','Error porcentual validación')
hold on
plot(Et1,'DisplayName','Error porcentual entrenamiento')
plot(ev1,'DisplayName','Error cuadrático validación')
plot(et1,'DisplayName','Error cuadrático entrenamiento')
title('Errores CA50')
lgd=legend;
lgd.NumColumns=2;

figure(F_CA50_tr);
plot(Ytt1)
hold on
plot(YT1)
title('CA50 Entrenamiento')

figure(F_CA50_val);
plot(Yv1)
hold on
plot(YV1)
title('CA50 Validación')

figure(F_errores_21);
plot(Ev21,'DisplayName','Error porcentual validación')
hold on
plot(Et21,'DisplayName','Error porcentual entrenamiento')
plot(ev21,'DisplayName','Error cuadrático validación')
plot(et21,'DisplayName','Error cuadrático entrenamiento')
lgd=legend;
lgd.NumColumns=2;
title('Errores Rendimiento')

figure(F_rend_tr);
plot(Ytt21)
hold on
plot(YT21)
title('Rendimiento Entrenamiento')

figure(F_rend_val);
plot(Yv21)
hold on
plot(YV21)
title('Rendimiento Validación') 

figure(F_errores_22);
plot(Ev22,'DisplayName','Error porcentual validación')
hold on
plot(Et22,'DisplayName','Error porcentual entrenamiento')
plot(ev22,'DisplayName','Error cuadrático validación')
plot(et22,'DisplayName','Error cuadrático entrenamiento')
lgd=legend;
lgd.NumColumns=2;
title('Errores NOx')

figure(F_NOx_tr);
plot(Ytt22)
hold on
plot(YT22)
title('NOx Entrenamiento')

figure(F_NOx_val);
plot(Yv22)
hold on
plot(YV22)
title('NOx Validación')