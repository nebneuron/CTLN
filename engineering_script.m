% engineering_script
%
% calls: patterns2sA.m, sA2soln.m, plot_soln.m
% created May 22, 2016, for using patterns2sA.m function in CTLN-basic

% STEP 1. Create adjacency matrix, sA, from a set of patterns and desired
% transitions between patterns (sequences and limit cycles):

% Example 1. 4-neuron bound/trot
% P = [1 0 1 0; 0 1 0 1; 1 1 0 0; 0 0 1 1]'; % mtx of patterns
% seqs = {[1 2 1],[3 4 3]}; % cell array of desired transitions
% sA = patterns2sA(P,seqs);

% Example 2. 6-neuron overlapping patterns
P = [1 0 1 0 1 0; 0 1 0 1 0 1; 1 1 1 0 0 0; 0 0 0 1 1 1]'; % mtx of patterns
seqs = {[1 2 1],[3 4 3]}; % cell array of desired transitions
sA = patterns2sA(P,seqs);

% STEP 2. Compute and plot solutions
% simulation parameters
T = 100; % simulation time length, in units of membrane timescale

% solve ODEs and plot solution (solution is returned in "soln" struct)
soln = sA2soln(sA,T);
plot_soln(soln);