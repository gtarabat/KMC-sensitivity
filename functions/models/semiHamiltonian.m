function y = semiHamiltonian( s )


N = length(s);
M = 1;

ii = zeros(M,N);

for k=1:M
    ii(k,:) = mod( (1:N) + k -(N+1),N ) + 1 ;
end


y = 0.5*sum( s .* sum( s(ii) ) );
 
end 
 
 