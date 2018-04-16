function [ T, R ] = CoordTransformation( theta )

%  theta [deg]
%  Coordinate Transformation Matrix
%  The coordinate transformation matrix is
T = [          cosd(theta)^2                       sind(theta)^2                         2*sind(theta)*cosd(theta);
               sind(theta)^2                       cosd(theta)^2                        -2*sind(theta)*cosd(theta);
          -sind(theta)*cosd(theta)         sind(theta)*cosd(theta)                  (cosd(theta)^2)-sind(theta)^2];
      
% The engineering-tensor interchange matrix [R] is
R = 	[ 1   0   0;
          0   1   0;
          0   0   2];

end

