clc, clear %format long
format shortG 

% Call genpath inside of addpath to add all subfolders
addpath(genpath('../MATERIAL_LIBRARY'));
addpath(genpath('../SOLVER'));

% winding = Sample_Winding;
% fiber = T700SC;
% resin = TGRADE_RED_COMP;
% warstwa = Ply(winding,fiber,resin)
 
ply = Validation_ply()

theta = [90,45,0];
% theta = [7,-7,-7,7];

% theta = [90,0,0,0];
% theta = [0,0,0,90];

plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, ply];
end

composite = Composite(plies, theta, 'coupling')
% kompozyt.ABD

%% PIPE DIMENSIONS
    r_kopyto = 0.05; %[m]
    length =  5; %[m] length
    pipe = Pipe(composite,r_kopyto,length)

	   
     
    Force = 100; %[Nm]
    pipe.FSigX_Pure_Bending(Force*pipe.length) 
    FreeF_Point( pipe.Ef , pipe.Iyy, Force, pipe.length)
%% TWISTING  
Mt = 100; %[Nm]

twist_angle_rad = FreeF_twist( Mt, pipe.length, composite.Gxy, pipe.Io ) %[rad]
twist_angle_deg = twist_angle_rad*180/pi       %[deg]

%%
fprintf('Iyy*Ex = %0.2f [N*m2] \n', pipe.Iyy*composite.Ex);
fprintf('Iyy*Ef = %0.2f [N*m2] \n', pipe.Iyy*pipe.Ef);

fprintf('\nIo*Gxy = %0.2f [N*m2] \n', pipe.Io*composite.Gxy);
fprintf('Io*Gt = %0.2f [N*m2] \n',  pipe.Io*pipe.Gt);

