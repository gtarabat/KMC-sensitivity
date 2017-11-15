function [ MEAN VAR ] = mean_var( MEAN, VAR, k_term, k)


if(k>1)
    VAR =  VAR + (( k_term - MEAN ).^2)*(k-1)/k;
end


MEAN = MEAN + ( k_term - MEAN )/k;