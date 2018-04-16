function [ F ] = StrainConcentrationFactor( Em, Ef2, Vf )

% SOURCE:
% Principles of Composite Material Mechanics - Ronald F. Gibson
% Transverse strength of a continous fiber-reinforced lamina chapt 4.32 p124

% Ef2     % Transverse Young's Modulus of Fibers [Pa]
% Em     % Young's Modulus of Matrix [Pa]
% Vf       % Volume Fraction of fibers [-]

% StrainConcentrationFactor can be used for calculating ultimate shear
% strength
% Shear Modulus of Fibers Gf [Pa] should be used as input instead of Ef2 %
% Shear Modulus of Matrix Gm [Pa] should be used as input instead of Em

d_over_s_square_array = sqrt(4*Vf/pi);
d_over_s_triangular_array  = sqrt( 2*sqrt(3)*Vf/pi);
d_over_s = (d_over_s_square_array + d_over_s_triangular_array)/2; % fibers are randomly packed so lets average ;p

F = 1/(d_over_s*(Em/Ef2 - 1)+1);

end

