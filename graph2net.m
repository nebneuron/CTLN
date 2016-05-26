function [W,A] = graph2net(sA,e,d)

% function [W,A] = graph2net(sA,e,d)
%
% sA = binary adjacency matrix for a directed graph
% e = epsilon value to control synaptic strengths (default: e = .25)
% d = delta value for inhibitory weights (default: d = 2*e)
%
% create matrix W for a threshold-linear network from directed graph 
% last modified june 22, 2015

if nargin < 2 || isempty(e)
    e = .25;
end;

if nargin < 3 || isempty(d)
    d = 2*e;
end;

% create matrix A from sA
A = e*(sA>0) - d*(sA<=0); % 1 -> eps, 0 -> - delta
A = A - diag(diag(A)); % reset diagonal to 0

% create matrix W from A: W = I - 11^t + eps*A
n = size(A,1);
W = eye(n) - ones(n,n) + A;  