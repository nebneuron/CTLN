function soln = threshlin_ode(W,b,T,X0)

% function soln = threshlin_ode(W,b,T,X0)
%
% W = n x n matrix of recurrent connections (n = #neurons)
% b = input vector - expects an n x 1 column vector or an n x m matrix
%     (m = # of different "switches" between b-vectors)
% T = amount of time in ode solution for each b-vector,
%     should be a vector of length m
% X0 = n x 1 column vector of initial conditions in firing rates
%
% the threshlin ode to be solved: x-dot = -x + [Wx + b]_+
%
% outputs:
% soln = structure with time, X (computed), and W,b,T,X0 (same as input)
%        soln.time = column vector of times for solution points
%        soln.X = length(time) x n array of rate vectors at each time
%
% plot solutions using "soln2dynamicsplot.m" or "soln2dynamics.m" (simpler)
% listen to solutions using "rates2sound.m"
%
% last modified on june 10, 2015

% errors and defaults......................................................
n=size(W,1);  % find n = #neurons
  
if n~=size(W,2) 
    error('W must be a square matrix');
end

if nargin<2 || isempty(b)
    b = ones(n,1);  % default is b = 1, uniform input
end

if n~=size(b,1)
    error('b must have same dimension as sides of W');
end;

m = size(b,2); % number of b-vectors input

if nargin<3 || isempty(T)
    T = 10*ones(1,m); % need to specify for each b-vector
end;

if nargin<4 || isempty(X0)
    X0 = zeros(n,1);
end;

% we'll package up solution into a structure...............................
soln.W = W;
soln.b = b;
soln.T = T;
soln.X0 = X0;
soln.X = [];
soln.time = [];

% solve threshlin ode for each b-vector, patch solutions...................
t0 = 0;
for i=1:m
    model = @(t,x)(-x + nonlin(W*x + b(:,i))); % the threshlin model
    tspan = [t0:.01:t0+T(i)];  % use time steps of ".01" in units of timescale
    [time,X] = ode45(model,tspan,X0);  % solve ode
    soln.X = [soln.X; X]; % concatenate solutions
    soln.time = [soln.time; time]; % concatenate times
    X0 = X(end,:)'; % reset initial condition for next b-vector
    t0 = soln.time(end); % reset initial time for next b-vector
end;

% auxiliary functions......................................................
function y=nonlin(x)
y=x;
y(x<0)=0;