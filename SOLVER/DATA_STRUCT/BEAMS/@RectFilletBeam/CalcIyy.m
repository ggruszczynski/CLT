function [ Iyy ] = CalcIyy( obj )


b = obj.b_inner; % inner dimension [m]
h = obj.h_inner; % inner dimension [m]
r = obj.r_inner; % inner radius of the fillet[m]
t = obj.total_thickness; % thickness [m]


%IYY_RECTANGLE_FILLET calculates the area moment of inertia. The area moment of inertia or second moment of area has a unit of dimension length4, 
% and should not be confused with the mass moment of inertia. 

% b - inner dimension [m]
% h - inner dimension [m]
% r - inner radius of the fillet[m]
% t - thickness [m]

% Iyy [m4]

R = r + t;

I1 = t*(h-2*r)^3 /12;
I2 = pi/8 * (1/2 * (R^4 - r^4) + (R^2 - r^2)*(h-2*r)^2);
I3 = t*(b-2*r)*(t^4 /3 + h^2 /4);


Iyy = 2*I1 + 4*I2 + 2*I3;

end

