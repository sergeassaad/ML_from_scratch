function [x_opt, f_opt, N_steps, Q1, Q2] = LineSearch(f,grad,B,x_0)

% Author: Serge Assaad
% Date: Oct. 24, 2017
%
% Description:
%     Unconstrained minimizer (implements family of line-search methods)
%     Uses backtracking and Armijo's rule to find learning rate
%
% Args:
%     f: Function to be minimized
%     grad: Expression for the function's gradient
%     B: Specifies system to solve for search direction (e.g. B = I for
%     steepest descent, B = Hessian(f) for Newton's method)
%     x_0: initial guess for function minimum
%
% Returns:
%     x_opt: minimum point
%     f_opt: function value at minimum
%     N_steps: number of optimization steps to achieve convergence
%     Q1: Metric 1 = ||x_(k+1) - x*||/||x_k - x*|| (length = N_steps)
%     Q2: Metric 2 = ||x_(k+1) - x*||/||x_k - x*||^2 (length = N_steps)
%     (Q1 & Q2 only significant if theoretical optimum is known)

%% Hyperparameters
alpha_0 = 1; % initial guess for step size
c = 10^-4; % constant for Wolfe conditions
rho = 0.8; % backtracking constant
conv_threshold = 10^-9;
x_opt_th = [1,1]; %theoretical optimum

%% Compute initial function values
f_0 = f(x_0);
grad_0 = grad(x_0);
B_0 = B(x_0);

%% Initialize sequences for f, gradient, and B
f_k = f_0;
grad_k = grad_0;
B_k = B_0;
x_k = x_0;
N_steps = 0;
Q1 = [];
Q2 = [];

%% Line Search
while(norm(f_k)/norm(f_0)>conv_threshold) %Convergence condition
    %update function, gradient, and B
    f_k = f(x_k);
    grad_k = grad(x_k);
    B_k = B(x_k);
    P_k = -B_k\grad_k; %Evaluate search direction
    alpha = alpha_0;
    while (f(x_k + alpha*P_k)>= f_k + c*alpha*grad_k'*P_k) %Backtracking
        alpha = rho*alpha;
    end
    x_k1 = x_k + alpha*P_k;
    Q1 = [Q1 norm(x_k1-x_opt_th)/norm(x_k-x_opt_th)];
    Q2 = [Q2 norm(x_k1-x_opt_th)/norm(x_k-x_opt_th)^2];
    N_steps = N_steps + 1;
    x_k = x_k1;
end
x_opt = x_k;
f_opt = f_k;
end