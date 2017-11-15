function  cvrg = COoxidation_coverage( s )

cvrg = zeros(1,3);

cvrg(1) = sum(sum(s==-1));
cvrg(2) = sum(sum(s== 0));
cvrg(3) = sum(sum(s== 1));


