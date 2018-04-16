function [ Nt_ply ] = NThermal_ply( C, CTE, z_inner, z_outer, dTemp )
%NTHERMAL_PLY - returns thermal forces due to temperature change [GPa - mm]

% C is stiffness matrix such that [stress] = [C][strain]
% CTE[1/K] - vector of CTE[alfa_x, alfa_y, alfa_xy] 
% z_outer[m] - distance from the middle surface to the outer surface of the ply (top --> bottom till MS, then notation switches ;) ) 
% dTemp[K] - temperature change 

Nt_ply = dTemp * C * CTE * ( z_inner - z_outer ); %[Pa - m]

end

