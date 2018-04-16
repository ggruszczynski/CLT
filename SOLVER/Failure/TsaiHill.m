function [ output ] = TsaiHill( Stress, StressUlt )

% Tsai-Hill : maximum strain energy approach
% LIMITATION: The Tsai-Hill failure criterion cannot predict different failure modes including fiber failure, matrix failure, and fiber-matrix interface failure.

% Stress = [Sig1, Sig2, Sig12]  - vector of stresses [MPa] in the coordsys
% aligned along fibers
% StressUlt = [Sig1Ult, Sig2Ult, Sig12Ult]  - vector of ultimate stresses [MPa]

% Convention 
% Sig1Ult - along fibers
% Sig2Ult - perpendicular to fibers
% Sig12Ult - shear

Sig1 = Stress(1);
Sig2 = Stress(2);
Sig12 = Stress(3);

Sig1Ult = StressUlt(1);
Sig2Ult = StressUlt(2);
% Sig12Ult = StressUlt(3); % not used


    if  (   (Sig1/Sig1Ult)^2 + (Sig2/Sig2Ult)^2 +  (2* Sig12/Sig2Ult)^2 - Sig1*Sig2/(Sig1Ult)^2     )  > 1
       output =  true; % composite will fracture 
    else
        output = false; % composite will withstand
    end
     
end

