function [numLambda] = eigen_val (L,b,lb,step,ub)
%Natural frequency of a beam simply supported at both ends

% L  %[m] total length of the beam
% b  %[m] distance from the end of the beam to the support

% lb = 1e-12;     % Set a lower bound for the function.
% step = 0.005;       
% ub = 5;         % Set an upper bound for the function.

 syms Lambda % symbolic variable

%% Boundary Conditions
BCmat = [ 
                sinh(Lambda*b)                 cosh(Lambda*b)                 sin(Lambda*b)                 cos(Lambda*b);
             Lambda^2*sinh(Lambda*b)        Lambda^2*cosh(Lambda*b)         -Lambda^2*sin(Lambda*b)          -Lambda^2*cos(Lambda*b);
                sinh(Lambda*(L-b))             cosh(Lambda*(L-b))             sin(Lambda*(L-b))             cos(Lambda*(L-b));
            Lambda^2*sinh(Lambda*(L-b))     Lambda^2*cosh(Lambda*(L-b))     -Lambda^2*sin(Lambda*(L-b))      -Lambda^2*cos(Lambda*(L-b));
];

% symCharPol= det(BCmat); % symbolic function - characteristic polynominal of the BCmatrix
% symLambda = feval(symengine, 'solve',symCharPol,Lambda) % symbolic solution from MuPad, for some reason MuPad knows that it has to solve symCharPol=0 

charPol = matlabFunction(det(BCmat)); % Convert the symbolic function to a MATLAB function



%% BRUTAL FORCE METHOD

% vpasolve(charPol(Lambda) == 0, Lambda, [lb ub]) % numerical solver, finds only one solution in [lb, ub]

range = lb : step : ub;
roz= size(range);
roz(:,1)=[];
numLambda(roz) = 0;             % Initializes, 'num' stands for numerical solution

% tic
for j=1:roz
  % Look for the zeros in the function's current time window.
    numLambda(j) = fzero(charPol, range(j));
end
% toc

% Make sure that there are no duplicates.
numLambda = unique(numLambda);
DUPE = diff([numLambda NaN]) < 1e-12;
numLambda(DUPE) = [];

numLambda(1) = []; % delete the first solution, which is negative...
% numLambda(4:end)=[]; % delete rest of solutions, since they corresponds to higher frequencies which are hard to extract from recording

numLambda = numLambda*L;

%% 
% eigen_val_plots;

end

