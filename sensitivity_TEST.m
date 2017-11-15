% This script compare the uncopled and the coupled method for various
% values of the "coarse-grained" q parameter.
%
% Author : Arampatzis Georgios (gtarabat@gmail.com)


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

epsilon = 1e-3;
[data1, data2, MODEL, species, T] = set_new_model(STR, 10, epsilon);


Col = {'k' , 'r' , 'b'};


s0 = init_lattice( species , data1.N, data1.dimension, 0);

ObservFunction = str2func( MODEL.observable );
nObs = length( ObservFunction(s0) );

t_res = 0 : 0.01 : T;
data1.t_res = t_res;
data2.t_res = t_res;


Ns = 100;

Q = [1 2 4 5 10 20 25 50 100];
nQ = length(Q);

VarQ = zeros( nQ, length(t_res));
local_q_time = zeros(1,nQ+1);

for kq = 1:nQ

    data1.q = Q(kq);
    data1.M = data1.N/data1.q;
    
    cMEAN = zeros(length(t_res),nObs);
    cVAR  = zeros(length(t_res),nObs);
    MEAN  = zeros(length(t_res),nObs);
    VAR   = zeros(length(t_res),nObs);


    
    for k=1:Ns
        

        
        %----------------------------------------------------------------------
        %   Run coupled system
        %----------------------------------------------------------------------
        tt1 = tic;
        
        data1.s = s0; data2.s = s0;
        [obs1C, obs2C ]  = spatial_ssa_coupled( data1, data2, T, MODEL);
        local_q_time(kq) = local_q_time(kq) + toc(tt1);
        
        [ cMEAN, cVAR ] = mean_var( cMEAN, cVAR, (obs1C-obs2C)/epsilon, k);
        %----------------------------------------------------------------------
        % Run naive coupling, i.e. run ssa two times
        %----------------------------------------------------------------------
        tt2 = tic;
        
        data1.s = s0; data2.s = s0;
        [obs1, obs2] = spatial_ssa_coupled_naive( data1, data2, T, MODEL);
        
        [ MEAN, VAR ] = mean_var( MEAN, VAR, (obs1-obs2)/epsilon, k);
        local_q_time(nQ+1) = local_q_time(nQ+1) + toc(tt2);
        
        %----------------------------------------------------------------------
        % Plot/Print results
        %----------------------------------------------------------------------
        dt = toc(tt1);
        fprintf('kq=%d %d/%d   ,   %f sec  (%f min) remaining  \n',kq,k,Ns, (Ns-k)*dt, (Ns-k)*dt/60  );
        
        
        figure(1)
        
        if( mod(k,2)==0 )
        subplot(3,3,1:9); hold off;

        for m = 1:nObs
            subplot(3,3,1)
                
                plot(t_res, MEAN(:,m),[Col{m} '--']); hold on
                plot(t_res,cMEAN(:,m),[Col{m} '-']); 
                title('Derivative estimation')
            subplot(3,3,2)
                plot(t_res, VAR(:,m)/k,[Col{m} '--']); hold on
                plot(t_res,cVAR(:,m)/k,[Col{m} '-']);
                title('Variance of Estimator')
            subplot(3,3,3)
                semilogy(t_res, VAR(:,m)./cVAR(:,m),[Col{m} '-']); hold on
                title('Ratio of Variance of Estimators')
                grid on; axis tight; drawnow;
                
            subplot(3,3,4:6); 
                plot(t_res, obs1C(:,m),[Col{m} '--']); hold on
                plot(t_res, obs2C(:,m),[Col{m} '-']);
                title('Coupled trajectories')
                axis tight; drawnow;
            subplot(3,3,7:9);
                plot(t_res, obs1(:,m),[Col{m} '--']); hold on
                plot(t_res, obs2(:,m),[Col{m} '-']); 
                title('unCoupled trajectories')
                axis tight; drawnow;
                
                save sensitivity_VS_q.mat
        end
        end
        

    end
    
    if(length(Q)>1)
        figure(2)
        VarQ(kq,:) = VAR(:,1)./cVAR(:,1); 
        plot(Q,VarQ(:,end),'x-')
    end    
end


local_q_time(1:nQ) = local_q_time(1:nQ) / Ns;
local_q_time(nQ+1) = local_q_time(nQ+1) / Ns/nQ;

%%
figure(1)
        for m = 1:nObs
            subplot(3,3,1)
                plot(t_res, MEAN(:,m),[Col{m} '--']); hold on
                plot(t_res,cMEAN(:,m),[Col{m} '-']); 
                title('Derivative estimation')
            subplot(3,3,2)
                plot(t_res, VAR(:,m)/k,[Col{m} '--']); hold on
                plot(t_res,cVAR(:,m)/k,[Col{m} '-']);
                title('Variance of Estimator')
            subplot(3,3,3)
                semilogy(t_res, VAR(:,m)./cVAR(:,m),[Col{m} '-']); hold on
                title('Ratio of Variance of Estimators')
                grid on; axis tight; drawnow;
                
            subplot(3,3,4:6); 
                plot(t_res, obs1C(:,m),[Col{m} '--']); hold on
                plot(t_res, obs2C(:,m),[Col{m} '-']);
                title('Coupled trajectories')
                axis tight; drawnow;
            subplot(3,3,7:9);
                plot(t_res, obs1(:,m),[Col{m} '--']); hold on
                plot(t_res, obs2(:,m),[Col{m} '-']); 
                title('unCoupled trajectories')
                axis tight; drawnow;
        end

