function [ Mt_ply] = MThermal_ply( C, CTE, z_inner, z_outer, dTemp )
%MTHERMAL_PLY - returns thermal moments due to temperature change [GPa - mm2]

% C is stiffness matrix such that [stress] = [C][strain]
% CTE[1/K] - vector of CTE[alfa_x, alfa_y, alfa_xy] 
% z_outer[m] - distance from the middle surface to the outer surface of the ply (top --> bottom till MS, then notation switches ;) ) 
% dTemp[K] - temperature change 

Mt_ply = (dTemp/2) * C * CTE * ( z_inner^2 - z_outer^2 ); %[Pa - m]
end
