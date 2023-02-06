%clear;clc;

%% Extracción de datos
fprintf('Extrayendo datos... \n')
%find_missfire;

%% Entrenamiento datos offline
nodos=80;
[beta_off,W_off]=EML_train(Xt,Yt,nodos);
[Y_off_t,error_por_off_t,error_off_t]=EML_prediction(beta_off,Xt,Yt,W_off);
[Y_off_v,error_por_off_v,error_off_v]=EML_prediction(beta_off,Xv,Yv,W_off);
[Y_off_ad,error_por_off_adap,error_off_adap]=EML_prediction(beta_off,Xonl,Yonl,W_off);
[Y_off_norm,error_por_off_tot,error_off_tot]=EML_prediction(beta_off,Xnorm,Ynorm,W_off);
fprintf('Entrenamiento offline, error: %.5f \n',mean(error_off_tot))

%% Creación y actualización de buffer
buffer_max=5000;
actualizacion_buffer=10;
datos_validacion=100;
tic
X_buffer=Xt;
Y_buffer=Yt;

salida=struct('W',0,'beta',0,'Y',0,'error',0,'mean_error',0,'error_por',0,'mean_error_por',0,'precision',0);
for i=1:length(Xonl)-datos_validacion
    
    if mod(i,actualizacion_buffer)==1 && i~=1 
        if length(X_buffer)==buffer_max || length(X_buffer)>=buffer_max
            X_buffer=[X_buffer(1+actualizacion_buffer:end,:);Xonl(i-actualizacion_buffer:i,:)];
            Y_buffer=[Y_buffer(1+actualizacion_buffer:end,:);Yonl(i-actualizacion_buffer:i,:)];
        else
            X_buffer=[X_buffer;Xonl(i-actualizacion_buffer:i,:)];
            Y_buffer=[Y_buffer;Yonl(i-actualizacion_buffer:i,:)];
        end
    end

    [beta,W]=EML_train(X_buffer,Y_buffer,nodos);
    salida(i).W=W;
    salida(i).beta=beta;
    [Y_salida,error_por,error]=EML_prediction(beta,Xonl(i:i+datos_validacion,:),Yonl(i:i+datos_validacion,:),W);
    Y_acierto=Yonl(i:i+datos_validacion,:);
    salida(i).Y=Y_salida;
    salida(i).error=error;
    salida(i).mean_error=mean(error);
    salida(i).error_por=error_por;
    salida(i).mean_error_por=mean(error_por);
    
    aciertos11=0;
    errores10=0;
    aciertos00=0;
    errores01=0;
    umbral=0.5;
 
    for i2=1:length(Y_salida)
        if Y_salida(i2)>=umbral && Y_acierto(i2)==1
            aciertos11=aciertos11+1;
        elseif Y_salida(i2)<umbral && Y_acierto(i2)==0
            aciertos00=aciertos00+1;
        elseif Y_salida(i2)>=umbral && Y_acierto(i2)==0
            errores10=errores10+1;
        elseif Y_salida(i2)<umbral && Y_acierto(i2)==1
            errores01=errores01+1;
        end  
    end
    %salidilla=[aciertos11, errores01, errores10, aciertos00]./length(Y_aciertos)
    
    aciertos_tot_11(i)=aciertos11/length(Y_acierto);
    errores_tot_01(i)=errores01/length(Y_acierto);
    aciertos_tot_00(i)=aciertos00/length(Y_acierto);
    errores_tot_10(i)=errores10/length(Y_acierto);
    if mod(i,100)==1
        fprintf('iteración %d, aciertos: %.5f \n',i ,(aciertos11+aciertos00)/length(Y_acierto))
    end
    
end
tiempo_total=toc
plot_eml_online;