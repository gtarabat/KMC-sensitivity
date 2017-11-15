function [ ii N_active ] = ISING_1D_neighborsOf( k, N)

N_active = 1;


M=1;

ii = [ k , (k-1):(k-M) , (k+1):(k+M) ];


ii = periodic_index( ii,N);


end 
 
 
 
 
 

function  ii= periodic_index( ii, N)
 
 ii = mod( ii -(N+1),N)+1;
 
 end
