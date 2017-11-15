function [data1 data2 MODEL species T] = set_new_model(STR, T, epsilon)
%
% This function sets all information needed from the sensitivity code
% to run the mode.
%
% Author : Arampatzis Georgios (gtarabat@gmail.com)



% =========================================================================
% =========================================================================
% =========================================================================

if(  strcmp(STR,'ISING_1D')  )
    MODEL.name = STR;
    
    data1.dimension = 1;
    
    
    data1.rcd.ca = 1;
    data1.rcd.cd = 1;
    data1.rcd.beta = 0.1;
    data1.rcd.J = 1;
    data1.rcd.h=0;
    
    data1.N = 100;

    
    MODEL.observable = 'ISING_1D_coverage';     data1.obsClass = [-1 1]/data1.N;
%     MODEL.observable = 'ISING_1D_hamiltonian';   data1.obsClass = [-1 0 1];
%     MODEL.observable = 'semiHamiltonian';


%     epsilon = 1e-3;
        
    data2 = data1;
    data2.rcd.beta = data2.rcd.beta + epsilon;
    
    species = [0 1];

%     T = 10;


% =========================================================================
% =========================================================================
% =========================================================================

elseif( strcmp(STR,'ISING_2D') )
    MODEL.name = 'ISING_2D';
    data1.dimension = 2;
    
    
    data1.rcd.ca = 1;
    data1.rcd.cd = 1;
    data1.rcd.beta = 0.1;
    data1.rcd.J = 1;
    data1.rcd.h=0;
    
    data1.N = 10;

    MODEL.observable = 'ISING_2D_coverage';  data1.obsClass = [-1 1]/data1.N;
    

%     epsilon = 1e-3;
        
    data2 = data1;
    data2.rcd.beta = data2.rcd.beta + epsilon;
    
    species = [0 1];

%     T = 10;
 
% =========================================================================
% =========================================================================
% =========================================================================

elseif( strcmp(STR,'DIFFUSION_1D') )
    
    MODEL.name = 'DIFFUSION_1D';

    data1.dimension = 1;
    
    
    data1.rcd.ca = 1;
    data1.rcd.cd = 1;
    data1.rcd.beta = 0.1;
    data1.rcd.J = 1;
    data1.rcd.h=0;
    data1.rcd.cdif = 1;
    data1.N = 100;

%     MODEL.observable = 'ISING_1D_coverage_half';     data1.obsClass = [-1 0 1]/data1.N;
    MODEL.observable = 'ISING_1D_coverage_half';     data1.obsClass = [-1 0 1]/50;
%     MODEL.observable = 'ISING_1D_hamiltonian';   data1.obsClass = [-1 0 1];
%     MODEL.observable = 'semiHamiltonian';

        
    data2 = data1;
    data2.rcd.beta = data2.rcd.beta + epsilon;
    
    species = [0 1];


% =========================================================================
% =========================================================================
% =========================================================================

elseif( strcmp(STR,'ZGB_1D') )

    MODEL.name = 'ZGB_1D';
    MODEL.observable = 'ZGB_1D_coverage';
    data1.dimension = 1;

    data1.N = 100;
    data1.rcd.k1 = 0.9;%0.54;
    data1.rcd.k2 = 1;%0.3;


%     epsilon = 1e-3;

    data2 = data1;
    data2.rcd.k2 = data1.rcd.k2 + epsilon;

    species = [-1 0 1];
    
%     T = 100;

% =========================================================================
% =========================================================================
% =========================================================================

elseif( strcmp(STR,'ZGB_DIFFUSION_1D') )

    MODEL.name = 'ZGB_DIFFUSION_1D';
    MODEL.observable = 'ZGB_1D_coverage';
    data1.dimension = 1;

    data1.N = 10;
    data1.rcd.k1 = 0.54;
    data1.rcd.k2 = 0.3;
    data1.rcd.k3 = 0.1;

%     epsilon = 1e-3;

    data2 = data1;
    data2.rcd.k2 = data1.rcd.k2 + epsilon;

    species = [-1 0 1];
    
%     T = 40;

% =========================================================================
% =========================================================================
% ========================================================================= 

elseif( strcmp(STR,'ZGB_2D') )

    MODEL.name = 'ZGB_2D';
    MODEL.observable = 'ZGB_2D_coverage';
    data1.dimension = 1;

    data1.N = 100;
    data1.rcd.k1 = 0.9; %0.54;
    data1.rcd.k2 = 1;   %0.3;

%     epsilon = 1e-1;

    data2 = data1;
    data2.rcd.k2 = data1.rcd.k2 + epsilon;

    species = [-1 0 1];
    
%     T = 1;

% =========================================================================
% ========================  Molecular Beam Epitaxy ========================
% =========================================================================

elseif( strcmp(STR,'MBE_1D') )
  
    MODEL.name = 'MBE_1D';
%     MODEL.observable = 'MBE_1D_roughness';    
    MODEL.observable = 'ISING_1D_coverage';

    data1.dimension = 1;
    data1.N = 100;
    data1.rcd.F  = 1;
    data1.epsilon = 10;
    data1.rcd.D(1) = 1e2;
    data1.rcd.D(2) = data1.rcd.D(1) * exp(-1*data1.epsilon);
    data1.rcd.ES = data1.rcd.D(1) * exp(-0);
    % s0( 350:650) = 1;
    
%     T = 4;
    
%     epsilon = 0.001;
    data2 = data1;
    data2.rcd.F  = data1.rcd.F + epsilon;

    species = [0 1];    
end