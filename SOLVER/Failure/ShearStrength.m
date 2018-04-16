function [ SigCUlt_12 ] = ShearStrength( G12, Gm, Gf, SigMUlt_12, Vf )
%SHEARSTRENGTH Summary of this function goes here
%   Detailed explanation goes here

% SOURCE:
% Principles of Composite Material Mechanics - Ronald F. Gibson
% Transverse strength of a continous fiber-reinforced lamina chapt 4.32 p124

% Gf - Shear Modulus of Fibers [Pa]
% Gm - Shear Modulus of Matrix [Pa]
% G12 - Shear modulus of ply [Pa]
% SigMUlt_12 - Ultimate shear strenght of the matrix [Pa]
% Vf   - Volume Fraction of fibers [-]



F = StrainConcentrationFactor ( Gm, Gf, Vf );

SigCUlt_12 = G12*SigMUlt_12/(Gm*F);

end

