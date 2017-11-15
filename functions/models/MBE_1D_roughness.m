function  rough = MBE_1D_roughness( s )


N = length(s);

m = sum(s)/N;

rough = sum(abs(s-m))/N;

