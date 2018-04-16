classdef Fiber % INTERFACE

    properties (Abstract, SetAccess = protected)
        Ef1 %Young's Modulus of Fibers [Pa] - Longitudinal
        Ef2 %Young's Modulus of Fibers [Pa] - Transverse
        Gf %Shear Modulus of Fibers [Pa]
        vf  %Poisson's Ratio of Fibers
        SigFUlt_1t %Longitudinal tensile strength of Fibers [Pa]

        alfa_f1 %CTE of Fibers [1/K] - Longitudinal
        alfa_f2 %CTE of Fibers [1/K] - Transverse
        rhof % density of Fibers [kg/m3]
    end
    
    methods
    end
    
end

