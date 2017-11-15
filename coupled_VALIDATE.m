clear;clc

addpath('functions/coupling/')
addpath('functions/ssa/')
addpath('functions/models/')
addpath('functions/aux/')

%========================= Select model ===================================
% STR = 'ISING_1D';
STR = 'DIFFUSION_1D';


epsilon = 1e-3;
[data1, data2, MODEL, species, T] = set_new_model(STR, 10, epsilon);

Col = {'k' , 'r' , 'b'};

s0 = init_lattice( species , data1.N, data1.dimension, 0);

ObservFunction = str2func( MODEL.observable );
nObs = length( ObservFunction(s0) );

t_res = 0 : 0.01 : T;
data1.t_res = t_res;
data2.t_res = t_res;

coupleMean1 = zeros(length(t_res),nObs);
coupleMean2 = zeros(length(t_res),nObs);
ssaMean1 = zeros(length(t_res),nObs);
ssaMean2 = zeros(length(t_res),nObs);
meanTime1 = 0;
meanTime2 = 0;


Ns = 50;

data1.q = 10; data2.q = data1.q;
data1.M = data1.N/data1.q; data2.M = data1.M;

for k=1:Ns
    %----------------------------------------------------------------------
    %   Run coupled system
    %----------------------------------------------------------------------
    fprintf('1. %d/%d ',k,Ns);

    data1.s = s0;
    data2.s = s0;

    tic;
    [ obs1 obs2 ]  = spatial_ssa_coupled( data1, data2, T, MODEL);
    t_toc = toc;
    meanTime1 = meanTime1 + t_toc;
    
    fprintf('\t %f sec \n',t_toc);
    
    
    coupleMean1 = coupleMean1 + ( obs1 - coupleMean1 )/k;
    coupleMean2 = coupleMean2 + ( obs2 - coupleMean2 )/k;
   

    %----------------------------------------------------------------------
    % Run naive coupling, i.e. run ssa two times
    %----------------------------------------------------------------------

    fprintf('2. %d/%d ',k,Ns);
    
    data1.s = s0;
    data2.s = s0;

    tic;
    [ obs1 obs2 ] = spatial_ssa_coupled_naive( data1, data2, T, MODEL);
    t_toc = toc;
    meanTime2 = meanTime2 + t_toc;
        
    fprintf('\t %f sec \n',t_toc);    
    
    ssaMean1 = ssaMean1 + ( obs1 - ssaMean1 )/k;
    ssaMean2 = ssaMean2 + ( obs2 - ssaMean2 )/k;
    
    
    %----------------------------------------------------------------------
    % Plot results
    %----------------------------------------------------------------------
    
    for m = 1:nObs
        subplot(1,2,1)   
            p=plot( t_res, coupleMean1(:,m),[Col{m} '-']); hold on
            set(p,'LineWidth',2);
            plot( t_res, ssaMean1(:,m),[Col{m} '--']);
            axis tight; drawnow; 

       subplot(1,2,2)
            p=plot( t_res,coupleMean2(:,m),[Col{m} '-']); hold on
            set(p,'LineWidth',2);
            plot( t_res,ssaMean2(:,m),[Col{m} '--']);
            axis tight; drawnow; 
    end
    
    subplot(1,2,1); hold off
    subplot(1,2,2); hold off
    
end


%%
meanTime1 = meanTime1/Ns;
meanTime2 = meanTime2/Ns;

meanTime1/meanTime2


