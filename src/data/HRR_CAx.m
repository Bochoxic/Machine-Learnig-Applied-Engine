%% IMPORTACION DATOS
%load('1500_1bar_barridoSA_0896.mat');
%% CALCULO DE PRESIONES, HRR Y CAx
% Calculo de presiones para evitar pegging
%[P1,P2,P3,P4]=presiones_admision(datos);
P1=N1750.p20.p1;
P2=N1750.p20.p2;
P3=N1750.p20.p3;
P4=N1750.p20.p4;
%Calculo de HRR y HR
[HRR1,HR1,HRR1r,HR1r]=calcHRR(P1,Calculos.Volumen,1.3);
[HRR2,HR2,HRR2r,HR2r]=calcHRR(P2,Calculos.Volumen,1.3);
[HRR3,HR3,HRR3r,HR3r]=calcHRR(P3,Calculos.Volumen,1.3);
[HRR4,HR4,HRR4r,HR4r]=calcHRR(P4,Calculos.Volumen,1.3);
%Calculo de CA10
CA10_1=calcCAx(HR1r,Calculos.Angulo,0.1);
CA10_2=calcCAx(HR2r,Calculos.Angulo,0.1);
CA10_3=calcCAx(HR3r,Calculos.Angulo,0.1);
CA10_4=calcCAx(HR4r,Calculos.Angulo,0.1);
%Calculo de CA50
CA50_1=calcCAx(HR1r,Calculos.Angulo,0.5);
CA50_2=calcCAx(HR2r,Calculos.Angulo,0.5);
CA50_3=calcCAx(HR3r,Calculos.Angulo,0.5);
CA50_4=calcCAx(HR4r,Calculos.Angulo,0.5);
%Calculo de CA90
CA90_1=calcCAx(HR1r,Calculos.Angulo,0.9);
CA90_2=calcCAx(HR2r,Calculos.Angulo,0.9);
CA90_3=calcCAx(HR3r,Calculos.Angulo,0.9);
CA90_4=calcCAx(HR4r,Calculos.Angulo,0.9);
%Guardamos los datos
Calculos.N1750.p20.HRR1=HRR1;
Calculos.N1750.p20.HRR2=HRR2;
Calculos.N1750.p20.HRR3=HRR3;
Calculos.N1750.p20.HRR4=HRR4;

Calculos.N1750.p20.CA10_1=CA10_1;
Calculos.N1750.p20.CA10_2=CA10_2;
Calculos.N1750.p20.CA10_3=CA10_3;
Calculos.N1750.p20.CA10_4=CA10_4;

Calculos.N1750.p20.CA50_1=CA50_1;
Calculos.N1750.p20.CA50_2=CA50_2;
Calculos.N1750.p20.CA50_3=CA50_3;
Calculos.N1750.p20.CA50_4=CA50_4;

Calculos.N1750.p20.CA90_1=CA90_1;
Calculos.N1750.p20.CA90_2=CA90_2;
Calculos.N1750.p20.CA90_3=CA90_3;
Calculos.N1750.p20.CA90_4=CA90_4;