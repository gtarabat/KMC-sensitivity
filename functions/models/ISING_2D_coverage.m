function  cvrg = ISING_2D_coverage( s )

cvrg = sum( sum( s ) ) / (size(s,1)*size(s,2));
