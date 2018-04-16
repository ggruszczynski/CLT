%-----------------ShearModulus(angle) ----------------%
 str = sprintf('Shear Modulus (angle) \n VolFib =%0.2f [-] \n Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [GPa] vf =%0.2f [-] \n Em=%0.2f [GPa] Gm =%0.2f [GPa] vm =%0.2f [-]', winding.VolF, fiber.Ef1*1e-9, fiber.Ef2*1e-9, fiber.Gf*1e-9, fiber.vf, resin.Em*1e-9, resin.Gm*1e-9, resin.vm);
% srt_file = sprintf('FailureModes_stress(FibreVolumeFraction)');
srt_file = sprintf('Gxy(angle)VolFib =%0.2f [-] Ef1=%0.2f [GPa] Ef2=%0.2f [GPa] Gf =%0.2f [GPa] vf =%0.2f [-]  Em=%0.2f [GPa]  Gm =%0.2f [GPa] vm =%0.2f [-]',winding.VolF, fiber.Ef1*1e-9, fiber.Ef2*1e-9, fiber.Gf*1e-9, fiber.vf, resin.Em*1e-9, resin.Gm*1e-9, resin.vm);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','ShearModulus');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(theta_step, Gt*1e-9, theta_step, Gxy*1e-9);
grid on;
xlabel('angle [deg] ');
ylabel('Shear Modulus [MPa]');
title(str);
legend('Gt','Gxy');


foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
