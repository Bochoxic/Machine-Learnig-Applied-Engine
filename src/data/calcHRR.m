function [HRR,HR,HRRr,HRr]=calcHRR(presion, volumen,k)
der_presion=diff(presion);
[a,b]=size(presion);
volumen_t=ones(a,b);
for i=1:b
        volumen_t(:,i)=volumen;
end
der_volumen=diff(volumen_t);
der_presion=[der_presion; der_presion(end,:)];
der_volumen=[der_volumen; der_volumen(end,:)];
HRR=(k/(k-1))*presion.*der_volumen+(1/(k-1))*volumen_t.*der_presion;
HR=cumsum(HRR);
HRRr=HRR(120:900,:);
HRr=HR(120:900,:);
end