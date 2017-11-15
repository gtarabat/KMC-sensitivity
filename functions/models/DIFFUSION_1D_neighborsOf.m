function [ ii N_active ] = DIFFUSION_1D_neighborsOf( k, N)


M=1;

N_active = 2*M+1;

% [ k  k-1  k+1  k-2  k+2  k-3  k+3]

ii = [ ((k-1):-1:(k-M))'  ((k+1):(k+M))'  ]';

ii = [ k ii(:)'];

ii = periodic_index( ii,N);


end 
 
 
 
 
 

function  ii= periodic_index( ii, N)
 
 ii = mod( ii -(N+1),N)+1;
 
 end
