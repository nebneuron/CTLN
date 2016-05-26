function plot_colors(colors)

n = size(colors,1);

for i=1:n
    plot([0,1],[i,i],'-','color',colors(i,:));
    hold on
end;
hold off
ylim([.75,n+.25])
set(gca,'XTick',[]); % to remove tick marks on x-axis