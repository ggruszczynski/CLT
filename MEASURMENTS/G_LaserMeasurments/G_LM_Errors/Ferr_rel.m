function [G_e_rel ] = Ferr_rel( this, measurment)
%ERROR_RELATIVE - returns relative error of G (shear Modulus) due to the
%errors in measurments of the quantities

% X_e_rel - relative error of the measured quantity 
% X_e_abs - absolute error of the measured quantity (b³ad bezwzgledny wartosci mierzonej)

this.Mt_e_rel = this.Mt_e_abs/measurment.Mt;
this.L_e_rel = this.L_e_abs/measurment.L;
this.Io_e_rel = this.Io_e_abs/measurment.Io_measured;
this.twist_angle_measured_rad_e_rel = this.twist_angle_measured_rad_e_abs/measurment.twist_angle_measured_rad;
this.twist_angle_measured_deg_e_rel = this.twist_angle_measured_rad_e_rel * 180/pi;

G_e_rel  = this.Mt_e_rel + this.L_e_rel + this.Io_e_rel + this.twist_angle_measured_rad_e_rel;
end

