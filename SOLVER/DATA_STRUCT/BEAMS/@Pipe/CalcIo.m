function [ I0] = CalcIo( obj)
% IY_PIPE calculates the polar moment of inertia (torsion) .

% outer radius [m]
% inner radius [m]
% Io [m4]

I0 = (pi/2)* (obj.r_outer^4 - obj.r_inner^4);
end

