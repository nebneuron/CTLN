function display_sA(sA)

% function display_sA(sA)
%
% sA = a binary matrix
% -> black squares are 1s
% -> white squares are 0s
% -> gray is for the diagonal, which is irrelevant
%
% last modified on mar 1, 2016

% gray diagonal, 1s in black, 0s in white
A = sA - eye(size(sA,1)); % make diagonal -1

% colors, from lowest to highest values
cmap = [.8 .8 .8; 1 1 1; 0 0 0];
colormap(cmap);
imagesc(A)
title('adjacency mtx: black = 1, white = 0')