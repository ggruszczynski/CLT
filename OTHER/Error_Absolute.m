function [ E_err_abs ] = Error_Absolute( rho_err_abs, rho, A_err_abs, A, I_err_abs, I, L_err_abs, L, f_err_abs, f, lambda_err_abs, lambda)
%ERROR_RELATIVE - returns absolute error of E (Young's Modulus) due to the
%errors in measurments of the quantities

% rho %[kg/m] material density 
% L %[m] length
% f %[Hz] frequency
% lambda  %[-] eigenvalue (mode shape)
% I % moment of inertia[m4]
% A  % area[m2]


% X_err - amount of the absolute error E (Young's modulus) caused by the absolute error of the measured quantity (czlon b³edu bezwzlednego modulu Younga spowodowana blednem bezwzglednym wartosci mierzonej)
% X_err_abs - absolute error of the measured quantity (b³ad bezwzgledny wartosci mierzonej)


rho_err = A/I* 4*pi^2*L^4*f.^2./lambda.^4 * rho_err_abs;
A_err = rho/I * 4*pi^2*L^4*f.^2./lambda.^4 * A_err_abs;
I_err = rho*A/I^2 *4*pi^2*L^4*f.^2./lambda.^4 * I_err_abs;
L_err = rho*A/I *16*pi^2*L^3*f.^2./lambda.^4 *L_err_abs;
f_err = rho*A/I *8*pi^2*L^4*f./lambda.^4 .*f_err_abs;
lambda_err = rho*A/I *16*pi^2*L^4*f.^2./lambda.^5 .* lambda_err_abs;

E_err_abs = rho_err + A_err + I_err + L_err + f_err + lambda_err;

end

