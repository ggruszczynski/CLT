function [ C12,S12 ] = PlyStiffnes12 (~, E1, E2, v12, v21, G12)

% E1 - Young's Modulus along Fibers [MPa]
% E2 - Young's Modulus Normal to Fibers [MPa]
% G12 - Shear Modulus [MPa]
% v12 - Poisson's Ratio [-]
% theta - Rotating angle [deg]

% source of the formulaas -->  http://www.efunda.com/formulae/solid_mechanics/composites/calc_ufrp_cs_arbitrary.cfm

% Given the material properties of a unidirectional lamina, this calculator constructs the stiffness matrix [C] and the compliance matrix [S] 
% of the lamina in the principal directions.
% If the angle of rotation of the lamina is given (other than 0 degree), 
% this calculator also constructs the stiffness matrix [] and the compliance matrix [] in the rotated directions.

%For both stiffness and compliant matrices are symmetric, i.e., 
% v12/E1 = v21/E2, thus:
% v21 = v12*(E2/E1);

% Stress-Strain Relations for Lamina for Principal Directions
% Stiffness matrix [C] in the principal direction is:
% [C] is the stiffness matrix such that [stress] = [C][strain]
C12 = [        E1/(1-v12*v21)                  v12*E2/(1-v12*v21)           0;  
           v21*E1/(1-v12*v21)                   E2/(1-v12*v21)              0;
                        0                           0                      G12];
                    
                    
% Compliance matrix [S] in the principal direction is:
% [S] is the compliance matrix such that [strain] = [S][stress]
S12 = [       1/E1                        -v12/E1                      0;
            -v21/E2                          1/E2                      0;
                0                            0                      1/G12];
            

end

            