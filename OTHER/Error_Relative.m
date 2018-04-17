function [ E_err_rel ] = Error_Relative( rho_err_abs, rho, A_err_abs, A, I_err_abs, I, L_err_abs, L, f_err_abs, f, lambda_err_abs, lambda)
%ERROR_RELATIVE - returns relative error of E (Young's Modulus) due to the
%errors in measurments of the quantities

% rho %[kg/m] material density 
% L %[m] length
% f %[Hz] frequency
% lambda  %[-] eigenvalue (mode shape)
% I % moment of inertia[m4]
% A  % area[m2]

% X_err - amount of the relative error E (Young's modulus) caused by the absolute error of the measured quantity (czlon b³edu wzglednego modulu Younga spowodowana blednem bezwzglednym wartosci mierzonej)
% X_err_abs - absolute error of the measured quantity (b³ad bezwzgledny wartosci mierzonej)


rho_err = rho_err_abs/rho;
A_err = A_err_abs/A;
I_err = I_err_abs/I;
L_err = 4*L_err_abs/L;
f_err = 2*f_err_abs./f;
lambda_err = 4*lambda_err_abs./lambda;

E_err_rel  = rho_err + A_err + I_err + L_err + f_err + lambda_err;

end

