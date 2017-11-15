function [ ii N_active] = ZGB_DIFFUSION_1D_neighborsOf( k, N)


N_active = 3;


ii = [ k ; k-1 ; k+1 ]';

ii = periodic_index( ii,N);


end 
 
 
 
 
 

function  ii= periodic_index( ii, N)
 
 ii = mod( ii -(N+1),N)+1;
 
 end
