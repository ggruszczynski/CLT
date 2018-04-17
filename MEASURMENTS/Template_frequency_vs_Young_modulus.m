clc, clear
format shortG
addpath(genpath('../SOLVER'));
addpath(genpath('E_Measurments'));  % Call genpath inside of addpath to add all subfolders
%% PIPE DIMENSIONS
    
%% GEOMETRY

% PIPE DIMENSIONS
%     r_mold = 0.035; %[m]
% 
%     pipe = Pipe;
% 
%     pipe.length =  5; %[m] length
%     pipe.r_inner = r_mold; % [m] inner radius
%     pipe.rho = 1000;%[kg/m3] material density
%     pipe.total_thickness = 0.005; %[m]

%     rurka

%% Belka ITEM 40x40
custom_beam = CustomBeam();

custom_beam.length = 1.601;  %[m] length
custom_beam.rho = 2700;   %[kg/m3] material density

custom_beam.Iyy = 9.30 *1e-8; % [m4] moment of inertia
custom_beam.area = 5.14 *1e-4; % [m2] area
custom_beam
      
%% MEASURMENT    
    E_expected = 70e9; %[Pa]  

%      f_measured = [  88.8 241 463 ];    %[Hz] measured frequency --> fft z autokorelacji
    f_measured = [  93 254 488 ];      %[Hz] measured frequency --> fft 
     

measurment = E_Measurment(custom_beam, E_expected, f_measured)
%     pomiarek = E_Measurment(rurka, E_expected, f_measured);

%% ERRORS
%     error = E_errors_pipe(rurka, pomiarek);

    error = E_errors_custom(custom_beam, measurment);
%     bledzik
    error.show_results(measurment)
