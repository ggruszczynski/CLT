function [ Iyy ] = CalcIyy(obj )
%IYY_RECTANGLE calculates the area moment of inertia. The area moment of inertia or second moment of area has a unit of dimension length4, 
% and should not be confused with the mass moment of inertia. 

% b - inner dimension [m]
% h - inner dimension [m]
% thickness [m]
% Iyy [m4]


B = obj.b_inner + 2*obj.total_thickness; % outer dimension [m]
H = obj.h_inner + 2*obj.total_thickness; % outer dimension [m]

Iyy = (B*H^3 - obj.b_inner*obj.h_inner^3)/12; % [m4]

end

