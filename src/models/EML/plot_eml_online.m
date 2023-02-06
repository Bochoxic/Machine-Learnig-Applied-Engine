salida=salida;
[b,c]=size(salida);
[d,e]=size(salida(1).Y);
a=ones(c+d,e);
for i=1:c
    if i==1
        a(i:d,:)=salida(i).Y(1:d,:);
    else
    a(i+d,:)=salida(i).Y(end,:);
    end
end
Y=Datos(numero_datos_entrenamiento+numero_datos_validacion+1:end,9:end);
Y_salida_sn=a.*((max(Y)+0.1)-(min(Y)-0.1))+(min(Y)-0.1);

for i=1:e
    figure;
    plot(Y(:,i));
    hold on;
    plot(Y_salida_sn(:,i));
end

error_por_CA10=ones(c,1);
error_por_CA50=ones(c,1);
error_por_CA90=ones(c,1);
error_por_rend=ones(c,1);
error_mean_tot=ones(c,1);
for i=1:c
    
    error_por_CA10(i)=mean(salida(i).error_por(1,1:3));
    error_por_CA50(i)=mean(salida(i).error_por(1,4:6));
    error_por_CA90(i)=mean(salida(i).error_por(1,7:9));
    error_por_rend(i)=mean(salida(i).error_por(10:12));
    error_mean_tot(i)=salida(i).mean_error;
end
e=[mean(error_por_CA10),mean(error_por_CA50),mean(error_por_CA90),mean(error_por_rend),mean(error_mean_tot)]
    
