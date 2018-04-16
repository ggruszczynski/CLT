function [ A ] = CalcArea(this )
%AREA_RECTANGULAR_BEAM Summary of this function goes here

% b - inner breath dimension [m]
% h - inner height dimension [m]
% t - thickness [m]
% A - area [m2]


H = this.h_inner +2*this.total_thickness;
B = this.b_inner +2*this.total_thickness;

A = B*H - this.b_inner*this.h_inner;

end

