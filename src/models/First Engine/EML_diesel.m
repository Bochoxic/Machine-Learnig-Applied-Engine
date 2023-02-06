
%% Extracción de datos
fprintf('Extrayendo datos... \n')
procesar_geometria;

%% Entrenamiento redes
error_por_t=zeros(50,salidas);
error_por_v=zeros(50,salidas);
error_t=zeros(50,salidas);
error_v=zeros(50,salidas);
fprintf('Entrenando EML... \n')
for i=1:200
    [beta,W]=EML_train(Xt,Yt,i);
    [Y_salida_t,error_por_t(i,:),error_t(i,:)]=EML_prediction_tanh(beta,Xt,Yt,W);
    [Y_salida_v,error_por_v(i,:),error_v(i,:)]=EML_prediction_tanh(beta,Xv,Yv,W);
end

figure; plot(mean(error_t'));hold on; plot(mean(error_v'));

tic
[beta,W]=EML_train(Xt,Yt,70);
tiempo_entrenamiento=toc;
[Y_salida_t,error_por_t_ind,error_t_ind]=EML_prediction_tanh(beta,Xt,Yt,W);
[Y_salida_v,error_por_v_ind,error_v_ind]=EML_prediction_tanh(beta,Xv,Yv,W);
