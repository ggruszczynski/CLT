classdef Winding  < handle
    %WINDING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        d_filament = 7 *1e-6; 		% [m] diameter of filament
        n_rolls = 4; 				% [-] number of rolls
        n_filaments = 12000;		% [-] number of filaments per Yarn 
        b_yarn = 10*1e-3;			% [m] yarn breadth  
    end
    
    properties (Abstract)
        VolF         				% [-] Volume fraction of fibers
    end
    
    
    methods
    end
    
end

