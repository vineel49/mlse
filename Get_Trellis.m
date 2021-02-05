% Trellis for M = 2, L=2
function [Prev_State,Prev_State_trans,Prev_Ip,Prev_Ip_trans,Outputs_prev]= Get_Trellis()
Prev_State = [1,2;3,4;1,2;3,4]; % PREVIOUS STATES
Prev_State_trans =  [1,3,1,3;2,4,2,4]; % TRANSPOSE OF P_State
Prev_Ip = [1,1;1,1;2,2;2,2]; % Previous inputs
Prev_Ip_trans = [1,1,2,2;1,1,2,2]; % tranpose of PREVIOUS INPUTS
Outputs_prev = [1,2;3,4;5,6;7,8];% GAMMA INDICES FOR THE ALPHA RECURSION (THINK OF BCJR ALGORITHM)
end