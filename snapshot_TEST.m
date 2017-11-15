clear;clc

addpath('functions/coupling/')
addpath('functions/ssa/')
addpath('functions/models/')
addpath('functions/aux/')

%%
%========================= Select model ===================================
% STR = 'ISING_1D';
STR = 'DIFFUSION_1D';
% STR = 'ZGB_1D';
% STR = 'MBE_1D';



[data1 data2 MODEL species T] = set_new_model(STR, 1, 0.1);

t_res = 0 : 0.01 : T;
data1.t_res = t_res;
data2.t_res = t_res;

s0 = init_lattice( species , data1.N, data1.dimension, 0);

data1.q = data1.N;
data1.M = data1.N/data1.q;
data1.s = s0; data2.s = s0;
[obs1C obs2C data1 data2]  = spatial_ssa_coupled( data1, data2, T, MODEL);
s11 = data1.s; s12 = data2.s;

data1.q = 1;
data1.M = data1.N/data1.q;
data1.s = s0; data2.s = s0;
[obs1C obs2C data1 data2]  = spatial_ssa_coupled( data1, data2, T, MODEL);
s21 = data1.s; s22 = data2.s;


%%

if(data1.dimension==1)
    subplot(212)
    plot(1:data1.N,s11,'g-o', 'MarkerEdgeColor','k', 'MarkerFaceColor','g'); hold on
    plot(1:data1.N,s12,'k-s', 'MarkerEdgeColor','k', 'MarkerFaceColor','k')
    axis tight
    
    subplot(211)
    plot(1:data1.N,s21,'g-o', 'MarkerEdgeColor','k', 'MarkerFaceColor','g'); hold on
    plot(1:data1.N,s22,'k-s', 'MarkerEdgeColor','k', 'MarkerFaceColor','k')
    axis tight
else
    
   
    
    image(s11)  
    
    
end





