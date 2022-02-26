%Sarah Dolan, ELEC 4700, February 2022
%% Question 1 ai)
% RUN THIS FROM PART_1_LAPLACE
% The purpose of this code is solve for the electro static potential in a
% rectangular region using the finite difference method. The y boundaries
% are not fixed.


function Vmap = Part_1_Laplace_ai(nX, nY)

% rectangular region
% number of points
nx =nX;
ny = nY; 

% boundary conditions
boundary_left = 1;
boundary_right = 0;

% matrix formation
V = zeros(nx, ny);
G = sparse(nx*ny, nx*ny);
B = zeros (1, nx*ny);

% distance between points
d = 1;
d2 = d^2;

% iteration through rectangle

for i = 1:nx
    for j = 1:ny
        n = j + (i-1)*ny;
        if i == 1 
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = boundary_left;
       
        elseif i == nx 
            G(n,:) = 0;
            G(n,n) = 1;
            B(n) = boundary_right;
      
        elseif j == 1
          %  G(n,:) = 0;
            G(n,n) = 1;
        %    B(n) = boundary_bottom;

        elseif j ==  ny
         %   G(n,:) = 0;
            G(n,n) = 1;
         %   B(n) = boundary_top;

         else
            nxm = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;

            G(n,n) = - 2/d2 ;
            G(n,nxm) = 1/d2;
            G(n,nxp) = 1/d2;
            G(n,nym) = 0;
            G(n,nyp) = 0;
        end
    end
end

%Potential map
V = G\B';
Vmap = zeros(nx, ny);
    for i = 1:nx
        for j = 1:ny
            n = j + (i - 1) * ny;
            Vmap(j, i) = V(n);
        end
    end
end
