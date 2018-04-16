clc, clear %format long
format shortG 


addpath(genpath('../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../SOLVER'));

% winding = Sample_Winding;
% fiber = T700SC;
% resin = TGRADE_RED_COMP;
% ply = Ply(winding,fiber,resin);


 valply = Validation_ply()
 valply.C12;
 
 [Cxy, Sxy] = valply.StiffnesXY(45);
 

% top-->bottom 
theta = [45,-45];



plies=[];
for i=1:numel(theta)% all plies from the same material
    plies = [plies, valply];
end

composite = Composite(plies, theta, 'nonzero_coupling');
composite.ABD;

% PIPE DIMENSIONS
    r_outer_mold = 0.035; %[m]
    length =  2; %[m]
    pipe = Pipe(composite,r_outer_mold, length);
	pipe
    
    
%%     
% fprintf('rurka.Iyy*composite.Ex = %0.2f [N*m2] \n', rurka.Iyy*composite.Ex);
% fprintf('rurka.Iyy*rurka.Ef = %0.2f [N*m2] \n',  rurka.Iyy*rurka.Ef);
%    
% 
% Mt = 123; %[Nm]
% 
% twist_angle_rad = FreeF_twist( Mt, rurka.length, composite.Gxy, rurka.Io ); %[rad]
% twist_angle_deg = twist_angle_rad*180/pi;       %[deg]
% 
% fprintf('\nrurka.Io*composite.Gxy = %0.2f [N*m2] \n', rurka.Io*composite.Gxy);
% fprintf('rurka.Io*rurka.Gt = %0.2f [N*m2] \n',  rurka.Io*rurka.Gt);


% belka_fillet = RectFilletBeam();
% belka_fillet.total_thickness =0.02;
% belka_fillet