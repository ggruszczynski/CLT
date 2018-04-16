function [ w ] = S_S_Point( Ex_beam , Iyy, F, beam_length )
%                           %
%           F               %
%----------beam-------------%
%                           %
%                           %

%%%%%%%%% units - input
% Ex_beam % flexural modules of the beam [Pa]
% Iyy % moment of inertia [m4]
% F % Force [N]
% beam_length  % [m]


% deflection
w = (F * beam_length^3)/(48*Ex_beam*Iyy); % [m]

end

