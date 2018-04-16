function [ w ] = FreeF_Point( Ex_beam , Iyy, F, beam_length )
%
%                                   F
%----------beam----------------------
%
%

%%%%%%%%% units - input
% Ex_beam % flexural modules of the beam [m4]
% Iyy % moment of inertia [m4]
% F % Force [N]
% beam_length  % [m]



% deflection
w = (F * beam_length^3)/(3*Ex_beam*Iyy); % [m]

end

