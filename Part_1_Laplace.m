%Sarah Dolan, ELEC 4700, February 2022
%% Question 1
% RUN THIS FILE FOR PARTS A and B
% The purpose of this code is solve for the electro static potential in a
% rectangular region using the finite difference method. Following this, 
% the accuracy of the finite deffirence method is evaluted by 
% completing an analytical series solution. Both solutions are plotted.

% Dimesions
nx = 100;
ny = nx; 
l = 1; % length
w = 3*l/2; % width

% Potential maps
V_a = Part_1_Laplace_a(nx, ny);
V_b = Part_1_Laplace_b (nx, ny, l, w);

%Plot Dimensions
length_plot = linspace(0, l, nx);
width_plot = linspace(0, w, ny);



% Plot A
figure('DefaultAxesFontSize',18)
surf( length_plot, width_plot, V_a);
colormap (winter);
title('Potential A, Finite Difference Matrix Solution')
xlabel('Width') 
ylabel('Length') 
zlabel('Potential (V)') 

% Plot B
figure('DefaultAxesFontSize',18)
surf(length_plot, width_plot, V_b);
colormap(hot);
axis([0 l  0 w  0 1])
title('Potential B, Analytical Series Solution')
xlabel('Width') 
ylabel('Length') 
zlabel('Potential (V)') 

% Plots A and B
figure('DefaultAxesFontSize',18)
surf( length_plot, width_plot, V_a, 'FaceColor','b','FaceAlpha',0.6, 'EdgeColor','none');
hold on
surf(length_plot, width_plot, V_b, 'FaceColor','r');
legend ("V_a","V_b")
axis([0 l  0 w  0 1])
title('Potential A and Potential B')
xlabel('Width') 
ylabel('Length') 
zlabel('Potential (V)') 




