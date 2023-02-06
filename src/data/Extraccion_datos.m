%%Extracción de datos
%Obtenemos las rpm, masa de fuel, temperatura (T2) y presión (P2) en la
%admisión, grado de carga (p), CA50, rendimiento y NOx
RPM=[data.N1750.p20.rpm(:);data.N1750.p40.rpm(:);data.N1750.p60.rpm(:);data.N2500.p20.rpm(:);data.N2500.p40.rpm(:);data.N2500.p60.rpm(:);data.N3000.p20.rpm(:);data.N3000.p40.rpm(:);data.N3000.p60.rpm(:)];
MF=[data.N1750.p20.mf(:);data.N1750.p40.mf(:);data.N1750.p60.mf(:);data.N2500.p20.mf(:);data.N2500.p40.mf(:);data.N2500.p60.mf(:);data.N3000.p20.mf(:);data.N3000.p40.mf(:);data.N3000.p60.mf(:)];
T2=[data.N1750.p20.T2(:);data.N1750.p40.T2(:);data.N1750.p60.T2(:);data.N2500.p20.T2(:);data.N2500.p40.T2(:);data.N2500.p60.T2(:);data.N3000.p20.T2(:);data.N3000.p40.T2(:);data.N3000.p60.T2(:)];
T2=fillmissing(T2,'constant',40);
P2=[data.N1750.p20.P2(:);data.N1750.p40.P2(:);data.N1750.p60.P2(:);data.N2500.p20.P2(:);data.N2500.p40.P2(:);data.N2500.p60.P2(:);data.N3000.p20.P2(:);data.N3000.p40.P2(:);data.N3000.p60.P2(:)];
p=[20*ones(5096,1);40*ones(4371,1);60*ones(4363,1);20*ones(6243,1);40*ones(6232,1);60*ones(6312,1);20*ones(7332,1);40*ones(7335,1);60*ones(7361,1)];
CA50=[Qdata.N1750.p20.Pcyl1.ca50(:);Qdata.N1750.p20.Pcyl1.ca50(5095);Qdata.N1750.p40.Pcyl1.ca50(:);Qdata.N1750.p40.Pcyl1.ca50(4370);Qdata.N1750.p60.Pcyl1.ca50(:);Qdata.N1750.p60.Pcyl1.ca50(4362);Qdata.N2500.p20.Pcyl1.ca50(:);Qdata.N2500.p20.Pcyl1.ca50(6242);Qdata.N2500.p40.Pcyl1.ca50(:);Qdata.N2500.p40.Pcyl1.ca50(6231);Qdata.N2500.p60.Pcyl1.ca50(:);Qdata.N2500.p60.Pcyl1.ca50(6311);Qdata.N3000.p20.Pcyl1.ca50(:);Qdata.N3000.p20.Pcyl1.ca50(7331);Qdata.N3000.p40.Pcyl1.ca50(:);Qdata.N3000.p40.Pcyl1.ca50(7334);Qdata.N3000.p60.Pcyl1.ca50(:);Qdata.N3000.p60.Pcyl1.ca50(7360)];
NOx=[data.N1750.p20.NOx(:);data.N1750.p40.NOx(:);data.N1750.p60.NOx(:);data.N2500.p20.NOx(:);data.N2500.p40.NOx(:);data.N2500.p60.NOx(:);data.N3000.p20.NOx(:);data.N3000.p40.NOx(:);data.N3000.p60.NOx(:)];
NOx(isnan(NOx)==1)=239.8;
%Cálculo del rendimiento
IMEP=[Qdata.N1750.p20.Pcyl1.imep(:);Qdata.N1750.p20.Pcyl1.imep(5095);Qdata.N1750.p40.Pcyl1.imep(:);Qdata.N1750.p40.Pcyl1.imep(4370);Qdata.N1750.p60.Pcyl1.imep(:);Qdata.N1750.p60.Pcyl1.imep(4362);Qdata.N2500.p20.Pcyl1.imep(:);Qdata.N2500.p20.Pcyl1.imep(6242);Qdata.N2500.p40.Pcyl1.imep(:);Qdata.N2500.p40.Pcyl1.imep(6231);Qdata.N2500.p60.Pcyl1.imep(:);Qdata.N2500.p60.Pcyl1.imep(6311);Qdata.N3000.p20.Pcyl1.imep(:);Qdata.N3000.p20.Pcyl1.imep(7331);Qdata.N3000.p40.Pcyl1.imep(:);Qdata.N3000.p40.Pcyl1.imep(7334);Qdata.N3000.p60.Pcyl1.imep(:);Qdata.N3000.p60.Pcyl1.imep(7360)];
rend=IMEP./MF;

%Montamos la matriz de datos y la desordenamos para tener datos de todos
%los grados de carga juntos
Datos=[RPM,MF,T2,P2,p,CA50,rend,NOx];
shuffledDatos=desordenar(Datos);
k=find(shuffledDatos(:,6)>25);
shuffledDatos(k,:)=[];
%Separamos los datos en entrenamiento y validación para todas las redes
a=round(size(RPM)*(2/3));
XT1=shuffledDatos(1:a,1:5);
YT1=shuffledDatos(1:a,6);
XV1=shuffledDatos(a+1:end,1:5);
YV1=shuffledDatos(a+1:end,6);
Y21=shuffledDatos(:,7);
Y22=shuffledDatos(:,8);