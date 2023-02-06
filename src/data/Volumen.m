Kc=16;
ang=-180:0.5:(540-0.5);
Lm=0.048;
Lb=0.152;
D=0.085;
Vdis=Lm*pi()*D^2/2;
VolA=(Lb+Lm-sqrt(Lb^2-(Lm^2).*(sind(ang).^2))-Lm.*cosd(ang)).*pi()*D^2/4+(Vdis/(Kc-1));
hold on
plot(VolA)