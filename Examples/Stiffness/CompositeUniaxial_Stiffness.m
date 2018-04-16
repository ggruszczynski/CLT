clc, clear %format long
format shortG 


addpath(genpath('../../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../../SOLVER'));
addpath(genpath('plots_scripts'));


%% define ply
winding = Sample_Winding;
fiber = T700S;
resin = TGRADE_RED_COMP;
ply = Ply(winding,fiber,resin);
%  ply = Validation_ply();


 %% loop   
theta_step  = 0:1:90; % [deg] 
roz = numel(theta_step);
theta0 = [0,0]; % top-->bottom 
r_outer_kopyto = 0.035; %[m]
length =  2; %[m]     

Ef(roz) = 0; %beam
Ex(roz) = 0; %composite
% Ey(roz) = 0;
Gt(roz) = 0; %beam
Gxy(roz) = 0; %composite
% vxy(roz) = 0;
% vyx(roz) = 0;
% %shear coupling coefficients
% nxxy(roz) = 0;  % stress state is defined as SigX ~= 0 and SigY = SigXY = 0 % measure of the amount of strain generated in the xy plane per unit normal strain along the direction of applied stress x
% nxyx(roz) = 0; % stress state is defined as SigXY ~= 0 and SigX = SigY = 0 % normal strain response alng the y direction deu to a shear stress in the xy plane
% 

tic
for i = 1: 1 : roz    
    %% define composite      
        theta = theta0 + theta_step(i);  
        plies=[];
        for k=1:numel(theta)% all plies from the same material
            plies = [plies, ply];
        end
        kompozyt = Composite(plies, theta, 'nonzero_coupling');


    %% PIPE DIMENSIONS
        rurka = Pipe(kompozyt,r_outer_kopyto, length);
    
    %% collect data
    Ef(i) = rurka.Ef;
    Ex(i) = kompozyt.Ex;
%     Ey(i) = 1/Sxy(2,2);
    Gt(i) = rurka.Gt;
    Gxy(i) = kompozyt.Gxy;
%     vxy(i) = -Sxy(1,2)*Ex(i);
%     vyx(i) = -Sxy(2,1)*Ey(i);
%     nxxy(i) = Sxy(1,3)/Sxy(1,1); % stress state is defined as SigX ~= 0 and SigY = SigXY = 0
%     nxyx(i) = Sxy(1,3)/Sxy(3,3); % stress state is defined as SigXY ~= 0 and SigX = SigY = 0
end
toc

YoungModulusPlot;
ShearModulusPlot;
% PoissonsRatioPlot;
% ShearCouplingCoeffPlot;


