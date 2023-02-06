%% Cálculo de missfire

test3=load('TJI\test3.mat');
missfire=ones(length(test3.data.IMEP),1);
new_imep=zeros(length(test3.data.IMEP),1);
for i=1:length(test3.data.IMEP)
    if test3.data.IMEP(i)<1.5*1e5
        missfire(i)=0;
    else
        new_imep(i)=test3.data.IMEP(i);
    end
end
test3.data.missfire=missfire;


test4=load('TJI\test4.mat');
missfire=ones(length(test4.data.IMEP),1);
new_imep=zeros(length(test4.data.IMEP),1);
for i=1:length(test4.data.IMEP)
    if test4.data.IMEP(i)<1.5*1e5
        missfire(i)=0;
    else
        new_imep(i)=test4.data.IMEP(i);
    end
end
test4.data.missfire=missfire;


test5=load('TJI\test5.mat');
missfire=ones(length(test5.data.IMEP),1);
new_imep=zeros(length(test5.data.IMEP),1);
for i=1:length(test5.data.IMEP)
    if test5.data.IMEP(i)<1.5*1e5
        missfire(i)=0;
    else
        new_imep(i)=test5.data.IMEP(i);
    end
end
test5.data.missfire=missfire;

%% Extracción de datos
fueldur=[test3.data.fueldur;test4.data.fueldur;test5.data.fueldur];
EGRpos=[test3.data.EGRpos;test4.data.EGRpos;test5.data.EGRpos];
THRpos=[test3.data.VGTpos;test4.data.VGTpos;test5.data.VGTpos];
SA=[test3.data.SA;test4.data.SA;test5.data.SA];
Pint=[test3.data.pint;test4.data.pint;test5.data.pint];
missfire=[test3.data.missfire;test4.data.missfire;test5.data.missfire];
Mair=[test3.data.mair;test4.data.mair;test5.data.mair];


%% Preparación datos
numero_datos_entrenamiento=3456;
numero_datos_validacion=1037;
Datos=[EGRpos,THRpos,SA,Pint,fueldur,Mair,missfire];
entradas=6;
salidas=1;

Datos_entrenamiento_validacion=Datos(1:numero_datos_entrenamiento+numero_datos_validacion,:);
Datos_adaptacion=Datos(numero_datos_entrenamiento+numero_datos_validacion+1:end,:);

Datos_mezc_ent_val=desordenar(Datos_entrenamiento_validacion);

Datos_norm=(Datos-(min(Datos)))./((max(Datos))-(min(Datos)));
Datos_mezc_ent_val_norm=(Datos_mezc_ent_val-(min(Datos_mezc_ent_val)))./((max(Datos_mezc_ent_val))-(min(Datos_mezc_ent_val)));
Datos_adaptacion_norm=Datos_norm(numero_datos_entrenamiento+numero_datos_validacion+1:end,:);

Xnorm=Datos_norm(:,1:entradas);
Ynorm=Datos_norm(:,entradas+1:end);

Xt=Datos_mezc_ent_val_norm(1:numero_datos_entrenamiento,1:entradas);
Yt=Datos_mezc_ent_val_norm(1:numero_datos_entrenamiento,entradas+1:end);

Xv=Datos_mezc_ent_val_norm(numero_datos_entrenamiento+1:numero_datos_validacion+numero_datos_entrenamiento,1:entradas);
Yv=Datos_mezc_ent_val_norm(numero_datos_entrenamiento+1:numero_datos_validacion+numero_datos_entrenamiento,entradas+1:end);

Xonl=Datos_adaptacion_norm(:,1:entradas);
Yonl=Datos_adaptacion_norm(:,entradas+1:end);

