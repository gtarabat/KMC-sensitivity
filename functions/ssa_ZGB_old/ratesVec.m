function r = ratesVec(s,i,j, N, rcd)

% t=[ 0 0.25 0.5 0.75 1];
t = [0 1 2 3 4];

[il ir ju jd] = neighborsOf_old(i,j,N);

suma1 = (s(i,ju)==0) + (s(i,jd)==0) + (s(il,j)==0) + (s(ir,j)==0);
suma2 = (s(i,ju)<0)  + (s(i,jd)<0)  + (s(il,j)<0)  + (s(ir,j)<0);
suma3 = (s(i,ju)>0)  + (s(i,jd)>0)  + (s(il,j)>0)  + (s(ir,j)>0);

c1 = 1-s(i,j)^2;
c2 = 0.5*s(i,j)*rcd.k2;

r(1) = c1 *  rcd.k1;
r(2) = c1 * ( 1-rcd.k1 ) * t(suma1+1);
r(3) = c2 * ( 1+s(i,j) ) * t(suma2+1);
r(4) = c2 * ( s(i,j)-1 ) * t(suma3+1); 