function rs = computeRate( ws, rcd, RatesFunction ) 


[r w] = RatesFunction( ws , rcd);

rs.rates = r;
rs.omega = w;

rs.c = sum(r);
    