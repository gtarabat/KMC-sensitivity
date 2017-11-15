clear; clc;
FILENAME = 'sensitivity_data_voronia_1.mat';

load(FILENAME)


plot_variance = @(x,lower,upper,color) set(fill([x,x(end:-1:1)],[upper,lower(end:-1:1)],color),'EdgeColor',color);

alpha = norminv(0.975);


figure1 = figure(1);
axes1 = axes('Parent',figure1,'FontSize',18,'FontName','Arial');

set(figure1,'InvertHardcopy','off','Color',[1 1 1]);

k=5; 
conf_interval = alpha*sqrt( Var(k,:)/(i-1)/i ); hold on
ciplot(Mean(k,:)-conf_interval, Mean(k,:)+conf_interval,t_res,[1 1 0])

p=plot( t_res, Mean(k,:) ); grid on; 

set(p,'Color','black','LineWidth',2);


xlabel('time')
ylabel('sensitivity')
legend('Confidence Interval','Derivative Estimation');

axis([0 40 -0.45 9.5])


% export_fig figure1.eps


%% -----------------------------------------------------------------------------------------------------------------------------
%% -----------------------------------------------------------------------------------------------------------------------------
col = {'b' 'r' 'g' 'y' 'k'};

figure2 = figure(2);
axes2 = axes('Parent',figure2,'FontSize',16,'FontName','Courier', 'FontWeight','bold');

set(figure2,'InvertHardcopy','off','Color',[1 1 1]);

for k = couplingInd
        p=semilogy( t_res, Var(k,:)/(i-1) ); grid on; hold on 
        set(p,'Color',col{k},'LineWidth',2);        
end

xlabel('time')
ylabel('variance')
legend('Uncoupled','CRN','Trivial Coupling','Unoptimized Coupling','Optimized Coupling')
legend('Location','SouthEast');
axis([0 40 0 10^4])
% axis tight;

% export_fig figure2.eps