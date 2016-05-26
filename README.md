# CTLN
This is matlab code to run simulations for the CTLN model introduced in https://arxiv.org/abs/1605.04463 .

This is a bare bones package to run simple simulations and make plots using the CTLN model. Details about the model can be found in the following preprint:

Diversity of emergent dynamics in competitive threshold-linear networks: a preliminary report.  
Katherine Morrison, Anda Degeratu, Vladimir Itskov & Carina Curto.  Available at https://arxiv.org/abs/1605.04463

The code was written by Carina Curto and Katherine Morrison, and packaged together on May 22, 2016.

SUMMARY OF THE CODE:

1. The adjacency matrix sA: 
The basic input object that defines a CTLN model is an nxn matrix "sA", which is the adjacency matrix for a simple directed graph on n nodes (neurons).  sA should be a binary matrix with zeros on the diagonal.  Our convention (due to the form of the ODEs) is that sA(i,j) = 1 iff j->i in the graph. sA is thus the transpose of the usual adjacency matrix.

2.  run_CTLN_model_script.m:
This is a sample executable that allows you to enter an sA matrix (or load a saved example matrix, or generate one at random with randDigraph.m), and then simulate the corresponding CTLN model with a choice of parameters and initial conditions. 

3. The simulations are done by the function sA2soln.m, which returns a "soln" structure.  The results are plotted using the function plot_soln.m, using "soln" as input.

4.  engineering_script.m:
This script illustrates how to use the function patterns2sA.m in order to engineer networks with prescribed dynamic patterns.
It also calls sA2soln.m and plot_soln.m.

5.  All other functions are either plotting routines, called by plot_soln.m,
or functions used in the simulations, called by sA2soln.m.
