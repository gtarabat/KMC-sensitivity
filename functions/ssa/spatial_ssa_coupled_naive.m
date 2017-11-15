function [ obs1 obs2 ] = spatial_ssa_coupled_naive( data1, data2, T, MODEL )
% 
% 
% 
% Author : Arampatzis Georgios (gtarabat@gmail.com)



obs1 = spatial_ssa( data1, T, MODEL);
obs2 = spatial_ssa( data2, T, MODEL);