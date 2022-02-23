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

density = (1/sigma_out) * ones(nx, ny);

%Boxes!
num_boxes = 2;
Boxes = {};

Box{1}.x =[1 nx/3];
Box{1}.y =[60 100];

Box{2}.x =[nx-nx/3 nx];
Box{2}.y =[60 100];


for n = 1:num_boxes
density(Box{n}.x(1):Box{n}.x(2), Box{n}.y(1):Box{n}.y(2)) = (1/sigma_in);
end


G = sparse(nx*ny);
% for i =1:nx
%     for j = 1:ny
%         [in_box, on_box] =  inpolygon(i, j, Box{1}.x, Box{1}.y);
%     end
% end
mesh(density);

