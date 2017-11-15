function y = ISING_1D_hamiltonian( s )


N = length(s);
M = 1;

ii = zeros(2*M,N);

for k=1:M
    ii( k ,:) = mod( (1:N) - k -(N+1),N ) + 1 ;
    ii(M+k,:) = mod( (1:N) + k -(N+1),N ) + 1 ;
end

y = 0.5*sum( s .* sum( s(ii) ) );
 
end 
 
 