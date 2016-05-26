function plot_graph(sA,colors)

% function plot_graph(sA,colors)
%
% This function plots all the nodes of the graph around a circle then puts
% a directed arrow from node j to node i if sA(i,j)=1

n=size(sA,1);

if nargin<2 || isempty(colors)
    colors = lines(n);
end;

% determine positions for nodes
idxs=1:n;
r=1;
x=r*cos(-(idxs-1)*2*pi/n + pi/2);
y=r*sin(-(idxs-1)*2*pi/n + pi/2);

% plot nodes
for i=1:n
    plot(x(i),y(i),'.','color',colors(i,:),'Markersize',30)
    hold on;
end

% plot arrows
for j=1:n
    for i=1:n
        if sA(i,j)==1
            dir=[x(i), y(i)]-[x(j),y(j)];
            quiver(x(j), y(j), dir(1), dir(2),.95,'-k','LineWidth',1);
        end
    end
end

% touch ups
xlim([-1.2*r, 1.3*r]); 
ylim([-1.2*r, 1.3*r]);
set(gca,'XTick',[]); % to remove tick marks on x-axis
set(gca,'YTick',[]); % to remove tick marks on y-axis
hold off;