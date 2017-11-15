function r = rates( data, x)

xx = [ x-data.Jrange : 1 : x-1 , x+1 : 1 : x+data.Jrange ];

xx = mod( xx -(data.N+1),data.N)+1;

 
U = data.rcd.J*sum( data.s( xx ) ) - data.rcd.h;

r = data.rcd.ca*(1-data.s(x)) + data.rcd.cd*data.s(x)*exp(-data.rcd.beta*U);




