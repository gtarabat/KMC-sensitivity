function y = my_resample( ts, t, t_res)


y = zeros( length(t_res), size(ts,2) );



for k=1:size(ts,2)
    
    a1 = timeseries(ts(:,k),t);

    b1 = resample(a1,t_res,'zoh');
    
    y(:,k) = squeeze( b1.Data );
end



