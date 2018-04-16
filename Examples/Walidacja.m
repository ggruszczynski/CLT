clc, clear %format long
format shortG 


addpath(genpath('../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../SOLVER'));

% winding = Sample_Winding;
% fiber = T700SC;
% resin = TGRADE_RED_COMP;
% ply = Ply(winding,fiber,resin);
% 
%             [Cxy, Sxy] = ply.PlyStiffnesXY(45);
%             1/Sxy(3,3); % [Pa] Gxy of the ply

 valply = Validation_ply()
 valply.C12;
 
 [Cxy, Sxy] = valply.StiffnesXY(45);
 
% 
%                          [Cxy, ~] = valply.StiffnesXY(60)
% 
%                         Cxy(1,3) = 0;
%                         Cxy(2,3) = 0;
%                         Cxy(3,1) = 0;
%                         Cxy(3,2) = 0;
% 
%                         Sxy = Cxy^-1;
%                         
%                         plyEx = 1/Sxy(1,1)
 
theta = [60, 30, 45, 0 , 15];
% theta = [45,-45,-45,45];

% theta = [0,0,0,0,90]; %  
% theta = [90,0,0,0,0]; % 
% 
% theta = [0,0,0,45,90]; % top-->bottom 
% 
valply_gruby = valply;
valply_gruby.thickness =0.001;

plies=[];
plies = [plies, valply];
plies = [plies, valply];
plies = [plies, valply];
plies = [plies, valply_gruby];
plies = [plies, valply];

% plies=[];
% for i=1:numel(theta)% all plies from the same material
%     plies = [plies, valply];
% end

composite = Composite(plies, theta, 'nonzero_coupling')
composite.ABD;

% PIPE DIMENSIONS
    r_mold = 0.035; %[m]
    length =  5; %[m] length
    pipe = Pipe(composite,r_mold,length);
	pipe
    
%     
fprintf('rurka.Iyy*composite.Ex = %0.2f [N*m2] \n', pipe.Iyy*composite.Ex);
fprintf('rurka.Iyy*rurka.Ef = %0.2f [N*m2] \n',  pipe.Iyy*pipe.Ef);
   

Mt = 123; %[Nm]

twist_angle_rad = FreeF_twist( Mt, pipe.length, composite.Gxy, pipe.Io ); %[rad]
twist_angle_deg = twist_angle_rad*180/pi;       %[deg]

fprintf('\nrurka.Io*composite.Gxy = %0.2f [N*m2] \n', pipe.Io*composite.Gxy);
fprintf('rurka.Io*rurka.Gt = %0.2f [N*m2] \n',  pipe.Io*pipe.Gt);


% belka_fillet = RectFilletBeam();
% belka_fillet.total_thickness =0.02;
% belka_fillet