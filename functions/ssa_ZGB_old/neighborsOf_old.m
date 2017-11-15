function [iu id jl jr] = neighborsOf_old(i,j,N)


iu = mod(i-1-(N+1),N)+1;
id = mod(i+1-(N+1),N)+1;


jl = mod(j-1-(N+1),N)+1;
jr = mod(j+1-(N+1),N)+1;