function [ twist_angle_rad] = FreeF_twist( Mt, length, Gxy_beam, J0 )
%FreeF_twist calculates the twist angle of the pipe
% [Nm] Mt 
% [m] length
% [Pa] Gxy
% [m4] Jo - polar moment of inertia


twist_angle_rad = Mt*length/(Gxy_beam*J0); %[rad]

end

