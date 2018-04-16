function [SigC, SigF, SigM] =  LongitudinalStrength_Tension (Vf, EpsC, Ef,SigFUlt, Em, SigMUlt)

%%%%%%%%%%%%%%%%%% LongitudinalStrength: matrix vs fibers:  who fails first %%%%%%%%%%%%%%%%%%%%%%%%%%
% The load is applied along the direction of the fibres

SigF = Ef *EpsC; % Stress carried by fibres
SigM = Em *EpsC; % Stress carried by matrix 

roz = numel(EpsC);
SigC(roz) = 0;

    for i = 1: 1 : roz  
        if SigM(i) > SigMUlt % Matrix fails
            SigM(i) = 0;
%                 if SigF(i) > SigFUlt % Fibers fail too        
%                     SigF(i) = 0;
%                 else
                    SigF(i) = (1/Vf -1)*SigMUlt + Ef*EpsC(i); % Stress carried by the fibres after the failure of the matrix
                    if SigF(i) > SigFUlt % Fibers fails eventually
                         SigF(i) = 0;
                    end             
%                 end
            SigC(i) = SigF(i);

        elseif SigF(i) > SigFUlt % Fibers fail
            SigF(i) = 0;
%                 if SigM(i) > SigMUlt % Matrix fails too
%                   SigM(i) = 0;
%                 else
                  SigM(i) = Em*EpsC(i) + (Vf/(1-Vf))*SigFUlt;
                   if SigM(i) > SigMUlt % Matrix fails evetually
                         SigM(i) = 0;
                   end
%                 end
            SigC(i) = SigM(i);     

        else  %nothing fails
            SigC(i) = SigF(i)*Vf + SigM(i)*(1-Vf); % Stress in the composite along the fiber direction
        end    
    end

end
