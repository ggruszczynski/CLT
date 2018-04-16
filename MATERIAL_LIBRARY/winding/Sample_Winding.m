classdef Sample_Winding < Winding
    %SAMPLE_PROCESS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        VolF = 0.50; % [-] Volume fraction of fibers
    end
    
    methods
        function this = ChangeVolF(this,newVolF) %matlab needs 'this pointer' as a first input for some reason Oo
            this.VolF = newVolF;
        end
    end
    
end

