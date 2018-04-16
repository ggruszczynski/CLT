function [ A ] = CalcArea( obj )
%AREA_PIPE Summary of this function goes here

% outer radius [m]
% inner radius [m]
% Io [m4]


A = pi*(obj.r_outer^2 - obj.r_inner^2);

end

