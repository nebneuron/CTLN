function plot_soln(soln,proj,colors);

% function function plot_soln(soln,proj,colors);
%
% soln = the structure which is the output of sA2soln
% proj = nx2 matrix, each column a projection direction
% colors = matrix of RGB colors for neurons
%
% last modified May 22, 2016
% calls functions: display_sA.m, plot_graph.m, plot_projection.m,
%   plot_grayscale.m, plot_ratecurves.m, plot_colors.m

sA = soln.sA;
n = size(sA,1);

if nargin < 2 || isempty(proj)
    proj = rand(n,2); % pick 2 random directions
end;

if nargin < 3 || isempty(colors)
    colors = lines(n);
end;

% make figure............................................................
figure(1)
display_sA(sA); % adjacency matrix

figure(2)
subplot(3,3,1); 
plot_graph(sA,colors); % draw the graph

% display phase space projection, for each 1/4 of recording
interv = [0 .25;.25 .5;.5 .75;.75 1];
pl = [3 4 8 9];
for i=1:4
    subplot(7,5,pl(i))
    plot_projection(soln.X,proj,interv(i,:));
    title(['quarter ' int2str(i)])
end;

% plot the solution
subplot(3,10,11:19); plot_grayscale(soln.X);
subplot(3,10,21:29); plot_ratecurves(soln.X,soln.time,colors);
subplot(3,15,45); plot_colors(colors);