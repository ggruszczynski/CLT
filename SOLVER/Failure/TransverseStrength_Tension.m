function [ SigCUltTT ] = TransverseStrength_Tension( E2, Em, Ef2, SigMUlt, Vf )
% SOURCE:
% Principles of Composite Material Mechanics - Ronald F. Gibson
% Transverse strength of a continous fiber-reinforced lamina chapt 4.32 p124

% SigMUlt - Ultimate tension strenght of the matrix [MPa]
% E2 - Young's modulus of the ply transverse to the fiber direction [GPa]
% Em - Young's Modulus of Matrix [GPa]
% Vf   - Volume Fraction of fibers [-]

F = StrainConcentrationFactor( Em, Ef2, Vf );

SigCUltTT = E2*SigMUlt/(Em*F);

end

