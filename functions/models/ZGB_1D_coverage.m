function  cvrg = ZGB_1D_coverage( s )

N = length(s);

cvrg = zeros(1,3);

cvrg(1) = sum( s==-1 ) / N;
cvrg(2) = sum( s== 0 ) / N;
cvrg(3) = sum( s== 1 ) / N;
