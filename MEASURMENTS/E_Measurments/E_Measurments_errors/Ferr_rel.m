function [E_err_rel ] = Ferr_rel( this, measured )
%ERROR_RELATIVE - returns relative error of E (Young's Modulus) due to the
%errors in measurments of the quantities

% rho %[kg/m] material density 
% L %[m] length
% f %[Hz] frequency
% lambda  %[-] eigenvalue (mode shape)
% I % moment of inertia[m4]
% A  % area[m2]

rho = measured.beam.rho ; %[kg/m] material density 
L = measured.beam.length ;%[m] length
f_exp = measured.f_expected; %[Hz] expected frequency
lambda = measured.lambda; %[-] eigenvalue (mode shape)
I = measured.beam.Iyy; % moment of inertia[m4]
A = measured.beam.area; % area[m2]

% X_err - amount of the relative error E (Young's modulus) caused by the absolute error of the measured quantity (czlon b³edu wzglednego modulu Younga spowodowana blednem bezwzglednym wartosci mierzonej)
% X_err_abs - absolute error of the measured quantity (b³ad bezwzgledny wartosci mierzonej)


rho_err = this.rho_err_abs/rho;
A_err = this.area_err_abs/A;
I_err = this.Iyy_err_abs/I;
L_err = 4*this.L_err_abs/L;
f_err = 2*this.f_err_abs./f_exp;
lambda_err = 4*this.lambda_err_abs./lambda;

E_err_rel  = rho_err + A_err + I_err + L_err + f_err + lambda_err;
end

