function [SigAppMax ] = TsaiHillUniaxial( StressUlt, theta )
% TsaiHillUniaxial returns maximum allowable stress [MPa] for given orientantion and ultimate strenght of the lamina
% LIMITATION: The Tsai-Hill failure criterion cannot predict different failure modes including fiber failure, matrix failure, and fiber-matrix interface failure.

SigUlt1 = StressUlt(1);
SigUlt2 = StressUlt(2);
SigUlt12 = StressUlt(3);

SigAppMax =    sqrt( 1/ ((cosd(theta)^2 /SigUlt1)^2 +  (sind(theta)^2 /SigUlt2)^2+ (0.5*sind(2*theta) /SigUlt12)^2 -  (cosd(theta)^2 * sind(theta)^2)/(SigUlt1^2 )));
end

