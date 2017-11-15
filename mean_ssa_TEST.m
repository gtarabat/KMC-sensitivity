clear;clc

addpath('functions/coupling/')
addpath('functions/ssa/')
addpath('functions/models/')
addpath('functions/aux/')

%========================= Select model ===================================

% STR = 'ISING_1D';
STR = 'DIFFUSION_1D';
% STR = 'ZGB_2D';
% STR = 'MBE_1D';

epsilon = 0.1;
[data1, data2, MODEL, species, T] = set_new_model(STR, 1, epsilon);


data.t_res = 0:0.1:T;

s0 = init_lattice( species , data.N, data.dimension, 0);

ObservFunction = str2func( MODEL.observable );
nObs = length( ObservFunction(s0) );

meanSSA = zeros(length(data.t_res),nObs);


Ns = 1e2;

for k = 1:Ns
    data.s = s0;
    
    tic;
    observable = spatial_ssa( data, T, MODEL); 
    toc;
    

    meanSSA = meanSSA + ( observable - meanSSA )/k;
    
    plot(data.t_res , meanSSA );
    grid on; drawnow;
        
    
end