function [ Iyy ] = CalcIyy( obj )
% IY_PIPE calculates the area moment of inertia. The area moment of inertia or second moment of area has a unit of dimension length4, 
% and should not be confused with the mass moment of inertia. 

% r_outer [m]
% r_inner [m]
% Iy [m4]

Iyy = (pi/4) * (obj.r_outer^4 - obj.r_inner^4);
end

