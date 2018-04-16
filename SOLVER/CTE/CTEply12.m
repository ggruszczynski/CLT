function [ ALFA12] = CTEply12( alfa_f1, alfa_f2, alfa_m, vf, vm, v12, Ef1, Em, VolF )
% 1D forms of CTE
%source: Principles of Composite Material Mechanics - Ronald F. Gibson:
% chapter 5.4, p150 - Analysis of Lamina Hygrothermal Behavior 

% Ef1- Young modulus of fibers in 1direction
% Em - Yooung modulus of matrix
% v12 - major Poisson's ratio
% vm -  Poisson's ratio of the Matrix
% vf  -  Poisson's ratio of the Fibers
% alfa_f1 - CTE of fibers in 1 direction
% alfa_m - CTE of matrix in 1 direction

%Volume fraction of the matrix
VolM = 1 - VolF;


alfa1 = (Ef1*alfa_f1*VolF +Em*alfa_m*VolM)/(Ef1*VolF + Em*VolM);

% alfa2 = (1 +vm)*alfa_m*VolM + (1+vf)*alfa_f1*VolF - alfa1*v12 % simplification - isotropic constituents - Ronald F. Gibson: 5.4 Micromechanics models for hygrothermal properties pp 150

%J. German: PODSTAWY MECHANIKI KOMPOZYTÓW W£ÓKNISTYCH: 7.1.7. Wspolczynnik poprzecznej rozszerzalnoœci cieplnej str145
alfa2 = (VolM*alfa_m + VolF*alfa_f2) + VolM*VolF*(Em*vf - Ef1*vm)*(alfa_f1 - alfa_m)/(Ef1*VolF + Em*VolM);

ALFA12 = [alfa1, alfa2, 0]';

end

