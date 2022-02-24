%Sarah Dolan, ELEC 4700, February 2022
%% Question 2
% The purpose of this code is solve for the electro static current in a
% rectangular region using the finite difference method. A "bottle-neck",
% high density region is added.

% Dimesions
nx = 250;
ny = 160; 
l = 1; % length
w = 3*l/2; % width

% Density Map
sigma_out = 1;
sigma_in = 10^-2;

sigma = (sigma_out) * ones(nx, ny);
cMap = (1/sigma_out) * ones(nx, ny);

%Boxes!
num_boxes = 2;
Boxes = {};

Box{1}.x =[1 nx/3];
Box{1}.y =[60 100];

Box{2}.x =[nx-nx/3 nx];
Box{2}.y =[60 100];


for n = 1:num_boxes
cMap(Box{n}.x(1):Box{n}.x(2), Box{n}.y(1):Box{n}.y(2)) = (1/sigma_in);
sigma(Box{n}.x(1):Box{n}.x(2), Box{n}.y(1):Box{n}.y(2)) = (sigma_in);
end




% for i =1:nx
%     for j = 1:ny
%         [in_box, on_box] =  inpolygon(i, j, Box{1}.x, Box{1}.y);
%     end
% end




G = sparse(nx*ny);
B = zeros(1,nx*ny);

for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;

        if i == 1
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;
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

            rxm = (cMap(i,j) + cMap(i-1,j))/2.0;
            rxp = (cMap(i,j) + cMap(i+1,j))/2.0;
            rym = (cMap(i,j) + cMap(i,j-1))/2.0;
            ryp = (cMap(i,j) + cMap(i,j+1))/2.0;

            G(n,n) = -(rxm+rxp+rym+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
        end

    end
end

V = G\B';

Vmap = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;

        Vmap(i, j) = V(n);
    end
end

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

eFlowx = cMap .* Ex;
eFlowy = cMap .* Ey;



    subplot(2, 2, 1), H = surf(cMap');
    set(H, 'linestyle', 'none');
    view(0, 90)
    subplot(2, 2, 2), H = surf(Vmap');
    set(H, 'linestyle', 'none');
    view(0, 90)
    subplot(2, 2, 3), quiver(Ex', Ey');
    axis([0 nx 0 ny]);
    subplot(2, 2, 4), quiver(eFlowx', eFlowy');
    axis([0 nx 0 ny]);


C0 = sum(eFlowx(1, :));
Cnx = sum(eFlowx(nx, :));
Curr = (C0 + Cnx) * 0.5;




