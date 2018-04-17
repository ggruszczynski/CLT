function [ G_e_abs ] = Ferr_abs( this, measurment)
%ERROR_RELATIVE - returns absolute error of G (Kirchoff Modulus) due to the
%errors in measurments of the quantities

L = measurment.L;
Io = measurment.Io_measured;
twist_angle = measurment.twist_angle_measured_rad;
Mt = measurment.Mt;

% X_err - amount of the absolute error of G (Kirchoff modulus) caused by the absolute error of the measured quantity (czlon b³edu bezwzlednego modulu Kirchoffa spowodowana blednem bezwzglednym wartosci mierzonej)
% X_err_abs - absolute error of the measured quantity (b³ad bezwzgledny wartosci mierzonej)


Mt_err = L/(Io* twist_angle)*this.Mt_e_abs;
L_err = Mt/(Io* twist_angle)*this.L_e_abs;
Io_err = Mt*L/(Io^2* twist_angle)*this.Io_e_abs;
twist_angle_err = Mt*L/(Io* twist_angle^2)*this.twist_angle_measured_rad_e_abs;


G_e_abs = Mt_err + L_err +Io_err + twist_angle_err ;
end

