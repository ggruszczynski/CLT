clc, clear
format shortG
addpath('../BeamProperties/BendingMomentsOfInertia');
addpath('../BeamProperties/Area');


%% MEASURED - Aluminum 6061-T4; 6061-T451 pipe vs FEM
    f_measured = [17.06 62.8 0 ];%[Hz] measured frequency w reku 
    
    L  = 2.600; %[m] total length of the beam
    b = 0.3; %[m] distance from the end of the beam to the support

 
    rho = 2700;   %[kg/m3] material density
  
    
    R = 0.03/2; % [m] outer radius
    r = 0.02/2; % [m] inner radius
    I = Iyy_Pipe(R,r);%[m4] moment of inertia
    A = Area_Pipe(R,r);%[m2] cross section area of a ba
%% EXPECTED YOUNG'S MODULUS AND FREQUENCY
%    lambda_b0 = [pi 2*pi 3*pi ] %[-] hinge-hinge eigenvalues (mode shape) if b=0
  
    lb = 1e-12;     % Set a lower bound for the eigen_val function. 
    step = 0.005;       
    ub = 5;         % Set an upper bound for the eigen_val function. In fact lambda is multiplied by L inside the eigen_val thus the output can exceed ub
    
    lambda = eigen_val (L,b,lb,step,ub)
   
    E_expected = 68.9 *1e9; % [GPa] expected Young's modulus
    f_expected = (lambda.^2) /(2*pi*L^2) * sqrt(E_expected*I/(rho*A)) %[Hz]

%% absolute errors in measurements - belka item
    L_err_abs = 0 * 0.002; %[m] absolute error in length 
    rho_err_abs = 0 * 0.001; %[kg/m3] absolute error in material density 
       
    A_err_abs = 0.00*1e-4; %[m2] absolute error in area
    I_err_abs = 0.00*1e-8; %[m4] absolute error in moment of inertia
    f_err_abs = 0.85;% [Hz] absolute error in frequency
    lambda_err_abs = 0.00*lambda; %[-] absolute error in eigenvalues      
   

%% ERRORES

    E_err_abs  = Error_Absolute( rho_err_abs, rho, A_err_abs, A, I_err_abs, I, L_err_abs, L, f_err_abs, f_expected(1), lambda_err_abs(1), lambda(1));
    E_err_rel = Error_Relative( rho_err_abs, rho, A_err_abs, A, I_err_abs, I, L_err_abs, L, f_err_abs, f_expected(1), lambda_err_abs(1), lambda(1));

    fprintf(' E_err_abs = %g [Pa] \n', E_err_abs)
    fprintf(' E_err_rel = %g [-] \n', E_err_rel)


%% YOUNG'S MODULUS
    E= rho*A/I *(2*pi*L^2*f_measured).^2 ./ lambda.^4;
    
    fprintf('\n');
    fprintf('E_measured = %g [Pa] \n', E)