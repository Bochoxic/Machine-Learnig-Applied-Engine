function [Presion_cyl1,Presion_cyl2,Presion_cyl3,Presion_cyl4]=presiones_admision(datos)

Presion_cyl1=datos.PXI.pcyl1;
Presion_cyl2=datos.PXI.pcyl2;
Presion_cyl3=datos.PXI.pcyl3;
Presion_cyl4=datos.PXI.pcyl4;

diff1=datos.PXI.pcyl1(1,:)-datos.PXI.pint(1,:);
diff2=datos.PXI.pcyl2(1,:)-datos.PXI.pint(1,:);
diff3=datos.PXI.pcyl3(1,:)-datos.PXI.pint(1,:);
diff4=datos.PXI.pcyl4(1,:)-datos.PXI.pint(1,:);

Presion_cyl1=Presion_cyl1-diff1;
Presion_cyl2=Presion_cyl2-diff2;
Presion_cyl3=Presion_cyl3-diff3;
Presion_cyl4=Presion_cyl4-diff4;

end