function [ E1, E2, G12, v12, v21 ] = MaterialConstants (~ , windingdata, fiber, resin)


VolF = windingdata.VolF;
Ef1 = fiber.Ef1;
Ef2 =fiber.Ef2; 
Gf = fiber.Gf;
vf =fiber.vf;
Em =resin.Em;
Gm =resin.Gm;
vm =resin.vm;

% source of the formulas --> http://www.efunda.com/formulae/solid_mechanics/composites/calc_ufrp_EGNu.cfm
%-----------CALCULATIONS --------------------------------------
%Volume fraction of the matrix
VolM = 1 - VolF;

%Young's modulus along the fiber direction E1 - equal strain
E1 = Ef1*VolF + Em*VolM;

%Young's modulus transverse to the fiber direction E2 - equal stress 
% E2 = Ef2*Em/(VolF*Em + VolM*Ef2);		% -->  equal stress model is a lower bond

                                              % fibres are not isotropic, thus a transverse Young modulus of fibres (Ef2) should be used
E2 = Em*((1-sqrt(VolF)) + sqrt(VolF)/(1-sqrt(VolF)*(1-Em/Ef2))); % micromechanical model 'Principles od Composite Material Mechanics' Ronald F. Gibson chapter 3, p 79 - effective moduli of a continous fiber-reinforced lamina
                                                                % check the semi empirical Halpin-Tsai model for more suited result 

%Shear modulus G12
% G12 = Gf*Gm/(VolF*Gm + VolM*Gf);
G12 = Gm*((1-sqrt(VolF)) + sqrt(VolF)/(1-sqrt(VolF)*(1-Gm/Gf))); % micromechanical model 'Principles od Composite Material Mechanics' Ronald F. Gibson chapter 3, p 79 - effective moduli of a continous fiber-reinforced lamina

%Major Poisson's ratio 12:
v12 = VolF*vf + VolM*vm; 

%Minor Poisson's ratio 21:
v21 = v12* E2/E1; % for transversly orthotropic materials



% If the material being tested is transversly orthotropic, the subscripts 2 and 3 are interchangeable, and we have:
% G13 = G12
% E3=E2
% v31=v21
% v23=v32
% G23 = E2/(2*(1+v32))


