%Sarah Dolan, ELEC 4700, February 2022
%% Question 1 b)
% The purpose of this code is solve for the electro static potential in a
% rectangular region using the analytical series solution. Following this, 
% the accuracy of the finite deffirence method can be evaluted.


% rectangular region
% number of points
nx = 100;
ny = nx; 
% dimensions
l = 1; % length
w = 3*l/2; % width

% Variables for calculation of points
x = linspace(-l, l, nx);
y = linspace(0, w, ny);

% Potential
V0 = 1; % Boundary potential
V = zeros(nx, ny); % Potential map

% Number of iterations
it = 100;

for i = 1 : nx
    for j = 1 : ny
         V_n = 0; % Potential summation reset to zero
         n = 1; % Reset iteration counter
        while n < 2*it
            V_n = V_n + (1/n) * (cosh(n * pi * x(i) /w) / cosh(n * pi * (l)/w))*sin(n * pi * y(j)/ w); % Calculation of potential
            n = n + 2;  % Odd integers only
        end
            V (i,j) = V_n; % Potential assigned for given potential on map
    end
end

V = V * 4 * V0/pi; % Multiplied by constant for appropriate V0

%Plot Dimensions

length_plot = linspace(0, l, nx);
width_plot = linspace(0, w, ny);

%Plot

figure

surf(length_plot, width_plot, V);
colormap(hot);
axis([0 l  0 w  0 1])

