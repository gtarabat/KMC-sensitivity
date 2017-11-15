function  cvrg = ZGB_2D_sub_coverage( data )

cvrg = zeros(1,3);

M = 1*data.N;

cvrg(1) = sum(sum(data.s(:,1:1)==-1));
cvrg(2) = sum(sum(data.s(:,1:1)== 0));
cvrg(3) = sum(sum(data.s(:,1:1)== 1));

cvrg = cvrg/M;
