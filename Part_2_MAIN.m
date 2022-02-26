%Sarah Dolan, ELEC 4700, February 2022
%% Question 2
% The purpose of this code is solve for the electro static current in a
% rectangular region using the finite difference method. A "bottle-neck",
% high density region is added.

nx = 80;
ny = 50; 
passageWidth = 10;
passageLength = 20;
numIt = 100;
sigmaBox = linspace(10^-3, 1, numIt);
mainCurrent = zeros(numIt, 1);

for n = 1:numIt
[current, mainCurrent(n)] = Part_2_MainCurrent (nx, ny, sigmaBox(n), passageLength, passageWidth);
axis([0 ny  0 nx  0 0.05])
surf(current)
xlabel('Width') 
ylabel('Length') 
zlabel('Current (A)') 
currentTitle= sprintf("%f", sigmaBox(n));
title(['Current with Changing \sigma' '\sigma = ' currentTitle]) 
axis([0 ny  0 nx  0 0.05])
pause(0.01);
end

figure
plot(sigmaBox, mainCurrent*1000)
title('Current vs \sigma','FontSize', 18)
xlabel('\sigma (1/ \Omega)','FontSize', 12) 
ylabel('Current (mA)','FontSize', 12)