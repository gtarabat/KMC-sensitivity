clc; clear

load sensitivity_vs_q.mat
VarQ(2:3,:) = [];
Q(2:3) = [];

fig = figure(1);

ax = axes('Parent',fig,'FontSize',16,'FontName','Arial');

set(fig,'InvertHardcopy','off','Color',[1 1 1]);


semilogy(t_res, VarQ(1,:),  'Color','k','LineWidth',2)
hold on
semilogy(t_res, VarQ(end,:),  'r--','LineWidth',2)


axis tight

legend('q=1','q=N')
xlabel('time')
ylabel('variance ratio')


%% ------------------------------------------------------------------------


fig = figure(2);

ax = axes('Parent',fig,'FontSize',16,'FontName','Arial');

set(fig,'InvertHardcopy','off','Color',[1 1 1]);


semilogy( [0 Q], [1 ; VarQ(:,end) ], ...
                        '-ok','LineWidth',2, ...                   
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',10)

ticks = 0:20:100;
ticks = [ticks Q];
ticks = unique( sort(ticks) );
set(gca,'XTick',ticks)

ticks=[1 10:10:100 200]; 
set(gca,'YTick',ticks);

set(gca,'YTickLabel',{'1'  '10' , '20' ,'','','50','','','','','100','200' } )


xlabel('q')
ylabel('variance ratio')
grid on

axis([0 100 1 10^2.5])



