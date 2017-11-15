function [sub N_active] = ISING_2D_neighborsOf( k, N)

N_active = 1;

N2 = N*N;

sub(1) = k;
sub(2) = fix((k-1)/N)*N + mod(k-1+N-1,  N)+1;
sub(3) = mod(k+N-1,  N2)+1;
sub(4) = fix((k-1)/N)*N + mod(k,N)+1;
sub(5) = mod(k-N-1+N2,N2)+1;
