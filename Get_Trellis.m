% Trellis for M = 2, L=2
function [P_State,P_State_trans,P_Ip,Ga_Inx]= Get_Trellis()
P_State = [1,2;3,4;1,2;3,4]; % PREVIOUS STATES
P_State_trans =  [1,3,1,3;2,4,2,4]; % TRANSPOSE OF P_State
P_Ip = [1,1,2,2;1,1,2,2]; % PREVIOUS INPUTS
Ga_Inx = [1,2;3,4;5,6;7,8];% GAMMA INDICES FOR THE ALPHA RECURSION (THINK OF BCJR ALGORITHM)
end