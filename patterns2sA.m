function sA = patterns2sA(P,seqs)

% function sA = patterns2sA(P,seqs)
%
% P = n x k matrix of k patterns (one per column) for n neurons (rows)
% seqs = cell array of index sets for how patterns string together
%        examples: seqs{1} = [1 2 3 1] is a limit cycle of patterns 123 
%                  seqs{2} = [2 4 5 6] is a sequence that ends at pattern 6
% sA = (n+m)x(n+m) adjacency matrix, where m is the number of transitions
%      between patterns
%
% created March 28, 2016

% final matrix will have the block form sA = [A B; C 0]
A = P*P'>0; % sA_{i,j} = 1 if neurons i and j co-fire in a pattern
B = [];
C = [];

% make outer-neuron blocks
for i=1:length(seqs)
    idx = seqs{i};
    for j=1:length(idx)-1
        C = [C; P(:,idx(j))']; % received pattern (row vector)
        B = [B P(:,idx(j+1))]; % target pattern (column vector)
    end;
end;

% build the full matrix and remove diagonal
sA = [A B; C zeros(size(C,1),size(B,2))];
sA = sA - diag(diag(sA));