function [ E_err_abs ] = Ferr_abs( this, measured)
%ERROR_RELATIVE - returns absolute error of E (Young's Modulus) due to the
%errors in measurments of the quantities

rho = measured.beam.rho ; %[kg/m] material density 
L = measured.beam.length ;%[m] length
f_exp = measured.f_expected; %[Hz] expected frequency
lambda = measured.lambda; %[-] eigenvalue (mode shape)
I = measured.beam.Iyy; % moment of inertia[m4]
A = measured.beam.area; % area[m2]


% X_err - amount of the absolute error E (Young's modulus) caused by the absolute error of the measured quantity (czlon b³edu bezwzlednego modulu Younga spowodowana blednem bezwzglednym wartosci mierzonej)
% X_err_abs - absolute error of the measured quantity (b³ad bezwzgledny wartosci mierzonej)


rho_err = A/I* 4*pi^2*L^4*f_exp.^2./lambda.^4 * this.rho_err_abs;
A_err = rho/I * 4*pi^2*L^4*f_exp.^2./lambda.^4 * this.area_err_abs;
I_err = rho*A/I^2 *4*pi^2*L^4*f_exp.^2./lambda.^4 * this.Iyy_err_abs;
L_err = rho*A/I *16*pi^2*L^3*f_exp.^2./lambda.^4 *this.L_err_abs;
f_err = rho*A/I *8*pi^2*L^4*f_exp./lambda.^4 .*this.f_err_abs;
lambda_err = rho*A/I *16*pi^2*L^4*f_exp.^2./lambda.^5 .* this.lambda_err_abs;

E_err_abs = rho_err + A_err + I_err + L_err + f_err + lambda_err;

end

