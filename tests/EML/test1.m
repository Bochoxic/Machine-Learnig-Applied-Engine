Et=zeros(50,1);
et=zeros(50,1);
Ev=zeros(50,1);
ev=zeros(50,1);
Extraccion_datos;
NormalizacionDatos;
for i=2:50
    [beta,W]=EML_train(XT,YT,i);
    Yv=EML_prediction(beta,XV,W);
    Ev(i)=mean(abs((Yv-datos.PXI.CA50_1(4001:5138))./datos.PXI.CA50_1(4001:5138)))*100;
    ev(i)=sqrt(mean((Yv-datos.PXI.CA50_1(4001:5138)).^2));
    Ytt=EML_prediction(beta,XT,W);
    Et(i)=mean(abs((Ytt-datos.PXI.CA50_1(1:4000))./datos.PXI.CA50_1(1:4000)))*100;
    et(i)=sqrt(mean((Ytt-datos.PXI.CA50_1(1:4000)).^2));
    
end
f1=figure;
f2=figure;
f3=figure;
figure(f1);
plot(Ev,'DisplayName','Error porcentual validación')
hold on
plot(Et,'DisplayName','Error porcentual entrenamiento')
plot(ev,'DisplayName','Error cuadrático validación')
plot(et,'DisplayName','Error cuadrático entrenamiento')
%axis([0 inf 0 80])
lgd=legend;
lgd.NumColumns=2;
figure(f2);
plot(Ytt)
hold on
plot(datos.PXI.CA50_1(1:4000))
figure(f3);
plot(Yv)
hold on
plot(datos.PXI.CA50_1(4001:5138))
