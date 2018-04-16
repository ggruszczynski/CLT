%CLT - CTE validation
%---------------Fiber Material Preperties-------------------
%T300
materialdata.Ef1 = 230;   %Young's Modulus of Fibers [GPa] - Longitudinal
materialdata.Ef2 = 23;   %Young's Modulus of Fibers [GPa] - Transverse
materialdata.Gf = 15;   %Shear Modulus of Fibers [GPa]
materialdata.vf = 0.22; %Poisson's Ratio of Fibers
materialdata.SigFUlt = 0; %Ultimate strenght of the fibres [MPa]

materialdata.alfa_f1=  -0.38e-6; %CTE of Fibers [1/K] - Longitudinal
materialdata.alfa_f2=  30.0e-6; %CTE of Fibers [1/K] - Transverse
materialdata.rhof = 1.8; % density of Fibers [g/cm3]

%---------------Matrix Material Preperties
%Biresin ®  CR84	 12 h / 55°C

materialdata.Em = 3.25 ;    %Young's Modulus of Matrix [GPa]
materialdata.Gm =  1.27 ;  %Shear Modulus of Matrix [GPa]
materialdata.vm = 0.35;       %Poisson's Ratio of Matrix  
materialdata.SigMUlt = 0; %Ultimate strenght of the matrix [MPa]

materialdata.alfa_m = 200e-6; %CTE of Matrix [1/K]
materialdata.rhom =1.196; % density of Matrix [g/cm3]

%---------------other
materialdata.EpsC = 0:0.00001:0.05;      % range of strains of the composite --> for analysis
materialdata.VolF = 0.0;                               % Volume Fraction of fibers [-]
materialdata.theta = 0;                             % [deg] angle of rotation (0 degree is the principal direction)

save materialdata;
% %CLT - CTE
% %---------------Fiber Material Preperties-------------------
% %YSH-501
% materialdata.Ef1 = 230;   %Young's Modulus of Fibers [GPa] - Longitudinal
% materialdata.Ef2 = 230;   %Young's Modulus of Fibers [GPa] - Transverse
% materialdata.Gf = 0;   %Shear Modulus of Fibers [GPa]
% materialdata.vf = 0.22; %Poisson's Ratio of Fibers
% materialdata.SigFUlt = 0; %Ultimate strenght of the fibres [MPa]
% 
% materialdata.alfa_f1=  -0.38e-6; %CTE of Fibers [1/K] - Longitudinal
% materialdata.rhof =1.8; % density of Fibers [g/cm3]
% 
% %---------------Matrix Material Preperties
% %Biresin ®  CR84	 12 h / 55°C
% 
% materialdata.Em =3.25 ;    %Young's Modulus of Matrix [GPa]
% materialdata.Gm =  0 ;  %Shear Modulus of Matrix [GPa]
% materialdata.vm = 0.35;       %Poisson's Ratio of Matrix  
% materialdata.SigMUlt = 0; %Ultimate strenght of the matrix [MPa]
% 
% materialdata.alfa_m = 200e-6; %CTE of Matrix [1/K]
% materialdata.rhom =1.196; % density of Fibers [g/cm3]
% 
% %---------------other
% materialdata.EpsC = 0:0.00001:0.05;      % range of strains of the composite --> for analysis
% materialdata.VolF =0;                               % Volume Fraction of fibers [-]
% materialdata.theta = 0;                             % [deg] angle of rotation (0 degree is the principal direction)
% 
% save materialdata;


% %CLT vs Autodesk Simulation Composite
% %---------------Fiber Material Preperties-------------------
% 
% materialdata.Ef1 = 238.0;   %Young's Modulus of Fibers [GPa] - Longitudinal
% materialdata.Ef2 = 238.0;   %Young's Modulus of Fibers [GPa] - Transverse
% materialdata.Gf = 5;   %Shear Modulus of Fibers [GPa]
% materialdata.vf = 0.21; %Poisson's Ratio of Fibers
% materialdata.SigFUlt = 396.5; %Ultimate strenght of the fibres [MPa]
% 
% materialdata.alfa_f1=  -0.38*10e-6; %CTE of Fibers [1/K] - Longitudinal
% materialdata.rhof =1.8; % density of Fibers [g/cm3]
% 
% %---------------Matrix Material Preperties
% %Biresin ®  CR84	 12 h / 55°C
% 
% materialdata.Em =3.250 ;    %Young's Modulus of Matrix [GPa]
% materialdata.Gm =  1.270 ;  %Shear Modulus of Matrix [GPa]
% materialdata.vm = 0.35;       %Poisson's Ratio of Matrix  
% materialdata.SigMUlt = 149; %Ultimate strenght of the matrix [MPa]
% 
% materialdata.alfa_m = 200*10e-6; %CTE of Matrix [1/K]
% materialdata.rhom =1.196; % density of Fibers [g/cm3]
% 
% %---------------others
% materialdata.EpsC = 0:0.00001:0.05;      % range of strains of the composite --> for analysis
% materialdata.Vf =0.6;                               % Volume Fraction of fibers [-]
% materialdata.theta = 30;                             % [deg] angle of rotation (0 degree is the principal direction)
% 
% save materialdata;


%%%%%%%%sample data
%Kevlar 49/CE3305
% E1 =82;             % [GPa]
% E2 = 4;              % [GPa]
% G12 = 2.8;         % [GPa]
% v12 = 0.25;        % [-]
% theta = 0;           % [deg] angle of rotation (0 degree is the principal direction)


% %example: E-Glass Fibre
% materialdata.Ef = 72;   %Young's Modulus of Fibers [GPa]
% materialdata.Gf = 30;   %Shear Modulus of Fibers [GPa]
% materialdata.vf = 0.21; %Poisson's Ratio of Fibers
% materialdata.SigFUlt = 800; %Ultimate strenght of the fibres [MPa]
% 
% %---------------Matrix Material Preperties
% materialdata.Em =5 ;    %Young's Modulus of Matrix [GPa]
% materialdata.Gm =  1 ;  %Shear Modulus of Matrix [GPa]
% materialdata.vm = 0.35 ;%Poisson's Ratio of Matrix  
% materialdata.SigMUlt = 120; %Ultimate strenght of the matrix [MPa]