clear;
%% Define Rosenbrock function and its gradient
f = @(x) 100*(x(2)-x(1).^2).^2 + (1-x(1)).^2;
dx1 = @(x) -400.*x(1).*(x(2)-x(1).^2)-2.*(1-x(1));
dx2 = @(x) 200.*(x(2)-x(1).^2);
grad = @(x) [dx1(x);dx2(x)];

%% Initial Guess
x_0 = [-1.2, -1.2];

%% Gradient Descent
B = @(x) eye(length(x));
[x_opt_GD, f_opt_GD, N_steps_GD,Q1_GD, Q2_GD] = unconstrained_minimizer(f,grad,B,x_0);

%% Newton's Method
%Compute Hessian
B = @(x)[-400.*(x(2)-3*x(1).^2)+2, -400.*x(1);...
         -400.*x(1), 200];
     
[x_opt_NM, f_opt_NM, N_steps_NM,Q1_NM, Q2_NM] = unconstrained_minimizer(f,grad,B,x_0);

%% Plot convergence metrics
figure(1); clf
subplot(2,1,1);
plot(1:length(Q1_GD), Q1_GD);
title('Q1 for GD');
subplot(2,1,2);
plot(1:length(Q2_GD), Q2_GD);
title('Q2 for GD');

figure(2); clf
subplot(2,1,1);
plot(1:length(Q1_NM), Q1_NM);
title('Q1 for NM');
subplot(2,1,2);
plot(1:length(Q2_NM), Q2_NM);
title('Q2 for NM');

