clear;clc

addpath('functions/coupling/')
addpath('functions/ssa/')
addpath('functions/models/')
addpath('functions/aux/')

%========================= Select model ===================================

% MODEL.name = 'MBE_1D';
% data.dimension = 1;
% data.N = 100;
% data.rcd.F  = 1;
% data.epsilon = 10;
% data.rcd.D(1) = 1e2;
% data.rcd.D(2) = data.rcd.D(1) * exp(-1*data.epsilon);
% data.rcd.ES = data.rcd.D(1) * exp(-0);
% s0 = zeros(data.N,1); 
% s0( 350:650) = 1;


MODEL.name = 'MBE_2D';
data.dimension = 2;
data.N = 100;
data.rcd.F  = 1;
data.epsilon = 5;
data.rcd.D(1) = 1e5;
data.rcd.D(2) = data.rcd.D(1) * exp(-1*data.epsilon);
data.rcd.D(3) = data.rcd.D(1) * exp(-2*data.epsilon);
data.rcd.D(4) = data.rcd.D(1) * exp(-3*data.epsilon);
data.rcd.ES   = data.rcd.D(1) * exp(-1*data.epsilon);
s0 = zeros(data.N,data.N); 
s0(1:5:100,1:5:100)=1;

T = 4;
 

data.s = s0;

spatial_ssa_show( data, T, MODEL); 

