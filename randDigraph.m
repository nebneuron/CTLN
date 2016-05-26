function sA = randDigraph(n,d,flag1,flag2)

% function sA = randDigraph(n,d,flag1,flag2)
%
% n = number of vertices (neurons)
% d = average degree of each node (default is .25*n)
% -> the total number of edges in the graph will be n*d
% flag1 = 1 if pairs of neurons can have only one directed edge
% -> default is 1 (this ensures an oriented graph)
% flag2 = 1 if outdegree of each neuron is at least 1; 0 if not.
% -> default is 1 (this ensures no sinks)
%
% output = sA, an nxn adjacency matrix that satisfies the conditions:
% (i) for each sA_{ij}, sA_{ji} pair, at most one is a "1"
% (ii) sA has at least one "1" in each column (outdegree >=1)
% (iii) diagonal entries are 0.
% (Note: (i) is not guaranteed if flag1 = 0, and
%       (ii) is not guaranteed if flag2 = 0.)
%
% last modified March 1, 2016

if nargin<2 || isempty(d)
    d=round(.25*n);
end;

if nargin<3 || isempty(flag1)
    flag1 = 1;
end;

if nargin<4 || isempty(flag2)
    flag2 = 1;
end;

% initialize sA and blockedEdges matrices
% -> blockedEdges will track what edges have already been placed and 
%    what must be avoided to guarantee the graph is oriented
sA = zeros(n);
blockedEdges = eye(n);

% we'll keep adding edges until the total number is numEdges = d*n
numEdges=0;

% now build the matrix sA, one edge at a time...

% first go column by column and generate a 1 somewhere in that
% column to ensure minimum outdegree of 1
if flag2 == 1
    for i=1:n
        % generate a random index between 1 and n
        idx=ceil(rand*n);
        % make sure not to choose a blocked edge
        while blockedEdges(idx,i) == 1
            idx=ceil(rand*n);
        end
        sA(idx,i)=1;
        numEdges=numEdges+1;
        blockedEdges(idx,i)=1;
        if flag1 == 1 % if the graph is oriented, block the symmetric edge
            blockedEdges(i,idx)=1;
        end
    end
end

% fill in remaining edges randomly until we hit numEdges = n*d
while numEdges < n*d
    idx1=ceil(rand*n);
    idx2=ceil(rand*n);
    % loop until you've created a legal edge to add
    while blockedEdges(idx1,idx2)==1
        idx1=ceil(rand*n);
        idx2=ceil(rand*n);
    end 
    sA(idx1,idx2)=1;
    numEdges=numEdges+1;
    blockedEdges(idx1,idx2)=1;
    if flag1 == 1 % if the graph is oriented, block the symmetric edge
        blockedEdges(idx2,idx1)=1;
    end
end