function r = rates( data, i,j)


j1 = mod( j-1 -(data.N+1),data.N ) + 1;
j2 = mod( j+1 -(data.N+1),data.N ) + 1;
i1 = mod( i-1 -(data.N+1),data.N ) + 1;
i2 = mod( i+1 -(data.N+1),data.N ) + 1;

suma = data.s(i,j1) + data.s(i,j2) + data.s(i1,j) + data.s(i2,j);

U = data.rcd.J*suma - data.rcd.h;

r = data.rcd.ca*(1-data.s(i,j)) + data.rcd.cd*data.s(i,j)*exp(-data.rcd.beta*U);