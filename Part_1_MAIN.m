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
V_ai = Part_1_Laplace_ai(nx, ny); %1D Potential
V_a = Part_1_Laplace_a(nx, ny); %Finite Difference
V_b = Part_1_Laplace_b (nx, ny, l, w); %Analytical solution

%Plot Dimensions
length_plot = linspace(0, l, nx);
width_plot = linspace(0, w, ny);
set(findall(gcf,'-property','FontSize'),'FontSize',12)
tiledlayout(2,2)

%Plot Ai, 1D Potential
ax1 = nexttile;
surface(width_plot, length_plot, V_ai);
title('Potential A, Finite Difference Matrix Solution, 1D')
shading interp;
xlabel('x') 
ylabel('y') 

% Plot A, Finite Difference
ax2 = nexttile;
surf( length_plot, width_plot, V_a);
title('Potential A, Finite Difference Matrix Solution')
xlabel('Width') 
ylabel('Length') 
zlabel('Potential (V)') 
colormap(ax2,winter);


% Plot B, Analytical solution
ax3 = nexttile;
surf(length_plot, width_plot, V_b);
axis([0 l  0 w  0 1])
title('Potential B, Analytical Series Solution')
xlabel('Width') 
ylabel('Length') 
zlabel('Potential (V)') 
colormap(ax3,hot);

% Plots A and B
ax4 = nexttile;
surf( length_plot, width_plot, V_a, 'FaceColor','b','FaceAlpha',0.6, 'EdgeColor','none');
hold on
surf(length_plot, width_plot, V_b, 'FaceColor','r');
legend (["V_a","V_b"], 'Location','northwest','Orientation','horizontal')
axis([0 l  0 w  0 1])
title('Potential A and Potential B')
xlabel('Width') 
ylabel('Length') 
zlabel('Potential (V)') 




