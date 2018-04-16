function [ ALFAXY ] = CTEplyXY( ALFA12, theta)
% ALFAXY = [ alfa_x, alfa_y, alfa_xy]                 -  CTE in arbitrary oriented coord sys    [1/K]

    [T, R] = CoordTransformation( theta );

    ALFAXY = T \ ALFA12 ; % Instead of multiplying by the inverse, use matrix right division (/) or matrix left division (\). That is: Replace inv(A)*b with A\b
    ALFAXY = R * ALFAXY ; % note that the third element in the vector ALFAXY is returned as alfa_xynot alfa_xy/2

end

