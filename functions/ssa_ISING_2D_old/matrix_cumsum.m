function res = matrix_cumsum(m)


N = length(m);

mm = reshape(m',1,N^2);

cmm = cumsum(mm);

res = reshape(cmm,N,N)';
