%clear;clc;
%procesar_geometria;
%% Prueba 1
%estructura_red=[entradas,20,salidas];
%NN_diesel;
%tiempo1=tiempo_entrenamiento;
%err__all_1=err_all;
%err_por_1=err_por;
%layer1=layer;
%clear layer estructura_red

%% Prueba 2
estructura_red=[entradas,20,salidas];
NN_diesel_sigmoide;
tiempo2=tiempo_entrenamiento;
err__all_2=err_all;
err_por_2=err_por;
layer2=layer;
clear layer estructura_red