function [ A ] = CalcArea( obj )
%AREA_RECTANGULAR_BEAM_FILLET Summary of this function goes here

% b - inner breath dimension [m]
% h - inner height dimension [m]
% t - thickness [m]
% r - inner radius of the fillet [m]

% A - area [m2]

R = obj.r + obj.total_thickness;

A1 = obj.total_thickness * (obj.h-2*obj.r);
A2 = pi * (R^2 - obj.r^2)/4;
A3 = obj.total_thickness * (obj.b-2*obj.r);

A = 2*A1 + 4*A2 + 2*A3;
end

