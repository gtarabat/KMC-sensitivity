function [ sub N_active] = COoxidation_neighborsOf(k,N)

N_active = 9;

[i,j] = ind2sub([N,N],k);

ii = [ i , i-1 , i-1 ,  i  , i+1 , i+1 , i+1 ,  i  , i-1 , i-2 , i-2 , i-1 , i+1 , i+2 , i+2 , i+1 , i-1];
jj = [ j ,  j  , j+1 , j+1 , j+1 ,  j  , j-1 , j-1 , j-1 , j-1 , j+1 , j+2 , j+2 , j+1 , j-1 , j-2 , j-2];

[ii jj] = periodic_index( ii,jj,N);

sub = sub2ind([N,N],ii,jj);


end 
 
 
 
 
 

function [ii jj] = periodic_index( ii,jj,N)
 
 ii = mod( ii -(N+1),N)+1;
 jj = mod( jj -(N+1),N)+1;
 
 end
 