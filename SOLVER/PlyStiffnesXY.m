function [ Cxy, Sxy ] = PlyStiffnesXY( C12, theta )

% Stiffness and Compliance Matrices for Angled Lamina            
% The stiffness matrix for a lamina of arbitry oriented coord sys can be expressed in
% terms of the stiffness matrix in the principal direction:

[ T, ~ ] = CoordTransformation( theta ) ;

 Cxy = T^-1 * C12*(T^-1)'; % [C] is the stiffness matrix such that [stress] = [C][strain]
 Sxy = Cxy^-1;             % [S] is the compliance matrix such that [strain] = [S][stress]
end

