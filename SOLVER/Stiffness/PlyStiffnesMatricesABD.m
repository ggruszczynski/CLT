function [ A, B, D] = PlyStiffnesMatricesABD( C, z_inner, z_outer )
% source Principles of Composite Material Mechanics - Ronald F. Gibson:
% chapter 7: Analysis of Laminates p207% 
% Forming Stiffness Matrices: A, B, and D

% C is stiffness matrix such that [stress] = [C][strain]
% z_outer - distance from the middle surface to the outer surface of the ply (top --> bottom till MS, then notation switches ;) )

A = zeros(3); % extensional stiffness
B = zeros(3); % coupling stiffness
D = zeros(3); % bending stiffness


    for i = 1 : 3       % columns
          for j = 1 : 3 % rows         
                A(i,j) =  C(i,j) *(z_inner - z_outer);
                B(i,j) =  C(i,j) *(z_inner^2 - z_outer^2);
                D(i,j) =  C(i,j) *(z_inner^3 - z_outer^3);
         end
    end

end 

