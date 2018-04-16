clc, clear %format long
format shortG 

% Call genpath inside of addpath to add all subfolders
addpath(genpath('../MATERIAL_LIBRARY'));
addpath(genpath('../SOLVER'));

% winding = Sample_Winding;
% fiber = T700SC;
% resin = TGRADE_RED_COMP;
% warstwa = Ply(winding,fiber,resin)
 
warstwa = Validation_ply()

theta = [90,45,0];
% theta = [7,-7,-7,7];

% theta = [90,0,0,0];
% theta = [0,0,0,90];

warstwy=[];
for i=1:numel(theta)% all plies from the same material
    warstwy = [warstwy, warstwa];
end

kompozyt = Composite(warstwy, theta, 'nonzero_coupling')
% kompozyt.ABD

%% PIPE DIMENSIONS
    r_kopyto = 0.05; %[m]
    length =  5; %[m] length
     rurka = Pipe(kompozyt,r_kopyto,length)

	   
     
     Force = 100; %[Nm]
     rurka.FSigX_Pure_Bending(Force*rurka.length) 
     FreeF_Point( rurka.Ef , rurka.Iyy, Force, rurka.length )
%% TWISTING  
% Mt = 100; %[Nm]
% 
% twist_angle_rad = FreeF_twist( Mt, rurka.length, kompozyt.Gxy, rurka.Io ) %[rad]
% twist_angle_deg = twist_angle_rad*180/pi       %[deg]

%%
fprintf('Iyy*Ex = %0.2f [N*m2] \n', rurka.Iyy*kompozyt.Ex);
fprintf('Iyy*Ef = %0.2f [N*m2] \n', rurka.Iyy*rurka.Ef);

% fprintf('\nIo*Gxy = %0.2f [N*m2] \n', rurka.Io*composite.Gxy);
% fprintf('Io*Gt = %0.2f [N*m2] \n',  rurka.Io*rurka.Gt);

