function  cvrg = ZGB_2D_coverage( s )


N = size(s,1)*size(s,2);

cvrg = zeros(1,3);

cvrg(1) = sum(sum( s==-1 )) / N;
cvrg(2) = sum(sum( s== 0 )) / N;
cvrg(3) = sum(sum( s== 1 )) / N;
