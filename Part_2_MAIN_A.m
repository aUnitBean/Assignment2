%Sarah Dolan, ELEC 4700, February 2022
%% Question 2
% The purpose of this code is solve for the electro static current in a
% rectangular region using the finite difference method. A "bottle-neck",
% high density region is added.

close all
set(0, 'DefaultFigureWindowStyle', 'docked')

% Dimesions
passageWidth = 10;
passageLength = 20;
nx = 80;
ny = 50; 
l = 1; % length
w = 3*l/2; % width

% Sigma Map
sigma_out = 1;
sigma_in = 10^-2;

cMap = (1/sigma_out) * ones(nx, ny);

% Boundary conditions
boundary_top = 0;
boundary_bottom = 0;
boundary_left = 1;
boundary_right = 0;

% distance between points
d = 1;
d2 = d^2;

%Boxes!
num_boxes = 2;
Boxes = {};
Box{1}.y =[1 1/2*(ny-passageWidth) ];
Box{1}.x =[1/2*(nx-passageLength) 1/2*(nx+passageLength)];
Box{2}.y =[1/2*(ny+passageWidth) ny];
Box{2}.x =[1/2*(nx-passageLength) 1/2*(nx+passageLength)];

for n = 1:num_boxes
cMap(Box{n}.x(1):Box{n}.x(2), Box{n}.y(1):Box{n}.y(2)) = (sigma_in); %Box positions of cMap assigned the desired internal sigma
end

% Matrices
G = sparse(nx*ny);
B = zeros(1,nx*ny);

%--------------------------------------------------------------------------
% Iterative Solution
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;

        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = boundary_left;

        elseif i == nx
            G(n, :) = 0;
            G(n, n) = 1;

        elseif j == 1
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nyp = j + 1 + (i - 1) * ny;

            rxm = (cMap(i, j) + cMap(i - 1, j)) / 2.0;
            rxp = (cMap(i, j) + cMap(i + 1, j)) / 2.0;
            ryp = (cMap(i, j) + cMap(i, j + 1)) / 2.0;

            G(n, n) = -(rxm+rxp+ryp);
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nyp) = ryp;

        elseif j ==  ny
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nym = j - 1 + (i - 1) * ny;

            rxm = (cMap(i, j) + cMap(i - 1, j)) / 2.0;
            rxp = (cMap(i, j) + cMap(i + 1, j)) / 2.0;
            rym = (cMap(i, j) + cMap(i, j - 1)) / 2.0;

            G(n, n) = -(rxm + rxp + rym);
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nym) = rym;
        else
            nxm = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;

            rxm = (cMap(i,j) + cMap(i-1,j))/d2;
            rxp = (cMap(i,j) + cMap(i+1,j))/d2;
            rym = (cMap(i,j) + cMap(i,j-1))/d2;
            ryp = (cMap(i,j) + cMap(i,j+1))/d2;

            G(n,n) = -(rxm+rxp+rym+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
        end

    end
end

%--------------------------------------------------------------------------
%Potential Solution

V = G\B';
Vmap = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;

        Vmap(i, j) = V(n);
    end
end


% Electric Field Solutions
for i = 1:nx
    for j = 1:ny
        if i == 1
            Ex(i, j) = (Vmap(i + 1, j) - Vmap(i, j));
        elseif i == nx
            Ex(i, j) = (Vmap(i, j) - Vmap(i - 1, j));
        else
            Ex(i, j) = (Vmap(i + 1, j) - Vmap(i - 1, j)) * 0.5;
        end
        if j == 1
            Ey(i, j) = (Vmap(i, j + 1) - Vmap(i, j));
        elseif j == ny
            Ey(i, j) = (Vmap(i, j) - Vmap(i, j - 1));
        else
            Ey(i, j) = (Vmap(i, j + 1) - Vmap(i, j - 1)) * 0.5;
        end
    end
end

Ex = -Ex;
Ey = -Ey;

% Current Solutions

eFlowx = cMap .* Ex;
eFlowy = cMap .* Ey;

current = (eFlowx.^2+eFlowy.^2).^0.5;
mainCurrent = current(nx/2,ny/2)

%--------------------------------------------------------------------------
%Figures
set(findall(gcf,'-property','FontSize'),'FontSize',12)

%Impedance Plot
surf(cMap');
colormap(hot)
title('\sigma Map','FontSize', 18);
xlabel('x','FontSize', 12) 
ylabel('y','FontSize', 12) 
zlabel('\sigma (1/ \Omega)','FontSize', 12) 

%Potential and Current Plots

figure
surf(Vmap');
shading interp;
title('Potential Map','FontSize', 12);
xlabel('x','FontSize', 12) 
ylabel('y','FontSize', 12) 
zlabel('Potential (V)','FontSize', 12) 

figure
tiledlayout(2,1)
ax1 = nexttile;
surf(current');
shading interp;
colormap(ax1,cool(20));
title('Current Map','FontSize', 12);
xlabel('x','FontSize', 12) 
ylabel('y','FontSize', 12) 
zlabel('Current (A)','FontSize', 12) 

nexttile;
quiver(eFlowx', eFlowy');
hold on
rectangle('Position',[Box{1}.x(1) Box{1}.y(1) (Box{1}.x(2)-Box{1}.x(1)) (Box{1}.y(2)-Box{1}.y(1)) ],'EdgeColor','b');
hold on
rectangle('Position',[Box{2}.x(1) Box{2}.y(1) (Box{2}.x(2)-Box{2}.x(1)) (Box{2}.y(2)-Box{2}.y(1)) ],'EdgeColor','b');
title('Current Flow','FontSize', 12);
xlabel('x','FontSize', 12) 
ylabel('y','FontSize', 12) 
axis([0 nx 0 ny]);

%Potential and Electric Field Plots
figure
tiledlayout(2,1)
ax1b = nexttile;
surf(Ex',Ey');
title('Electric Field Map','FontSize', 12);
xlabel('x','FontSize', 12) 
ylabel('y','FontSize', 12) 
zlabel('Electric Field (V/m)','FontSize', 12) 
shading interp;
colormap(ax1b,cool(20));

nexttile;
quiver(Ex', Ey');
hold on
rectangle('Position',[Box{1}.x(1) Box{1}.y(1) (Box{1}.x(2)-Box{1}.x(1)) (Box{1}.y(2)-Box{1}.y(1)) ],'EdgeColor','b');
hold on
rectangle('Position',[Box{2}.x(1) Box{2}.y(1) (Box{2}.x(2)-Box{2}.x(1)) (Box{2}.y(2)-Box{2}.y(1)) ],'EdgeColor','b');
title('Electric Field Vectors','FontSize', 12);
xlabel('x','FontSize', 12) 
ylabel('y','FontSize', 12) 
axis([0 nx 0 ny]);



% figure
% surf(cMap', current');
% title('Current vs \sigma','FontSize', 12);
% xlabel('x','FontSize', 12) 
% ylabel('y','FontSize', 12) 



