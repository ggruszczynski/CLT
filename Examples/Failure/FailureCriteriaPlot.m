%-----------------FailureCriteria: stress(theta) ----------------%
 str = sprintf('FailureModes: stress(theta) \n sigma_{1Ult}=%0.0f[MPa] \t sigma_{2Ult}=%0.0f[MPa] \t sigma_{12Ult}=%0.0f[MPa]  ', StressUlt(1)*1e-6, StressUlt(2)*1e-6, StressUlt(3)*1e-6 );
srt_file = sprintf('stress(theta) sigma1Ult=%0.0f  sigma2Ult=%0.0f sigma12 Ult=%0.0f ', StressUlt(1)*1e-6, StressUlt(2)*1e-6, StressUlt(3)*1e-6);
srt_file = strrep(srt_file, '.', ','); %zamieniamy '.' na ',' w nazwie pliku aby sie kompilowalo w latexie
figure ('name','FailureModes');
set(gcf,'Position',get(0,'Screensize')/1.5) % enlarge image to ( .../1.5) full screen
plot(theta, StressUltXY(1,:), theta, StressUltXY(2,:) ,theta, StressUltXY(3,:), theta, SigAppMaxTHU );
grid on;
xlabel('Orientation [deg] ');
ylabel('Stress [MPa]');
title(str);
legend('Fibre Tensile','Matrix tensile','Matrix Shear', 'Tsai-Hill');
xlim([0,90]); % Set the x-axis limit to match the range of data.
ylim([0,StressUltCllipping ]); % Set the y-axis limit to match the range of data.




foldername = 'myplots';
if ~exist(foldername,'dir')
    mkdir(foldername)
end
cd(foldername)
print('-djpeg','-r300',srt_file);
cd ..
