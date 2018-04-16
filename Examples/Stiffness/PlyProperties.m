 clc, clear %format long
format shortG 


addpath(genpath('../../MATERIAL_LIBRARY')); % Call genpath inside of addpath to add all subfolders
addpath(genpath('../../SOLVER'));
addpath(genpath('plots_scripts'));


%% define ply
winding = Sample_Winding;
fiber = T700S;
resin = Biresin_CR84;
ply = Ply(winding,fiber,resin)
% 
% winding.ChangeVolF(0.7);
% ply = Ply(winding,fiber,resin)

 %% loop   
% % VolF_step  = 0:0.01:1; % [-]  
% % roz = numel(VolF_step);
% % 
% % ply(roz) = 0; %beam
% % 
% % for i = 1: 1 : roz        
% %         winding.ChangeVolF(VolF_step(i));
% %         ply(i) = Ply(winding,fiber,resin);
% %         
% % end
% % 
% % 
% % Ply_E1vsVolF_Plot
% % Ply_E2vsVolF_Plot