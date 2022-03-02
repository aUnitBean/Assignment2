%Sarah Dolan, ELEC 4700, February 2022
%% Question 2
% The purpose of this code is solve for the electro static current in a
% rectangular region using the finite difference method. A "bottle-neck",
% high density region is added.


nx = 80;
ny = 50; 
sigma =10^-2;


passageWidth = 10;
passageLength = 20;

numIt = 20;
numSize = 10;
numLength = 10;
numWidth = 10;


sigmaBox = linspace(10^-3, 1, numIt); %For varrying sigma
mainCurrentVarSigma = zeros(numIt, 1); %For collecting array of main channel currents when varying sigma

varNx = ones(numSize, 1); %For varying nx, for the mesh size
for i = 1: numSize
    varNx (i) = 10 * i;
end
c = jet(numSize);
mainCurrentVarSize = zeros(numSize, 1);  %For collecting array of main channel currents when varying size


mainCurrentVarPassage = zeros(numLength, 1);
varLength = ones(numLength, 1);
for i = 1: numLength
    varLength (i) = varLength(i)+i;
end

mainCurrentVarWidth = zeros(numWidth, 1);
varWidth = ones(numWidth, 1);
for i = 1: numWidth
    varWidth (i) = varWidth(i)+i;
end


%--------------------------------------------------------------------------
figure
%Varrying Sigma
for n = 1:numIt
[currentVarSigma, mainCurrentVarSigma(n)] = Part_2_MainCurrent (nx, ny, sigmaBox(n), passageLength, passageWidth);
axis([0 ny  0 nx  0 0.05])
surf(currentVarSigma,'FaceAlpha',0.4);
xlabel('Width') 
ylabel('Length') 
zlabel('Current (A)') 
currentTitle= sprintf("%f", sigmaBox(n));
title(['Current with Changing \sigma' '\sigma = ' currentTitle]) 
axis([0 ny  0 nx  0 0.05])
pause(0.01);
end

%-------------------------------------------------------------------------
figure
%Varrying Mesh Size
for m = 1 : numSize
[currentVarSize, mainCurrentVarSize(m)] = Part_2_MainCurrent (varNx(m), varNx(m), sigma, 5, 10);
surf(currentVarSize, 'FaceAlpha', 0.4, 'FaceColor', c(m, :));
hold on
axis([0 100  0 100  0 0.12])
xlabel('Mesh Width','FontSize', 12) 
ylabel('Mesh Length','FontSize', 12) 
zlabel('Current (A)') 
title('Current with Changing Mesh Size','FontSize', 18);
pause(0.01);
end

%--------------------------------------------------------------------------
%Varrying Bottlneck Length
figure
for m = 1 : numLength
[currentVarPassage, mainCurrentVarPassage(m)] = Part_2_MainCurrent (nx, ny, sigma, 2*varLength(m), 10);
surf(currentVarPassage', 'FaceAlpha', 0.4, 'FaceColor', c(m, :));
hold on
axis([0 nx  0 ny  0 0.1])
xlabel('X','FontSize', 12) 
ylabel('Y','FontSize', 12) 
zlabel('Current (A)') 
title('Current with Changing Bottle-neck Length','FontSize', 18);
pause(0.01);
end
%--------------------------------------------------------------------------
%Varrying Bottlneck Width
figure
for m = 1 : numWidth
[currentVarWidth, mainCurrentVarWidth(m)] = Part_2_MainCurrent (nx, ny, sigma, 5,  2*varWidth(m));
surf(currentVarWidth', 'FaceAlpha', 0.4, 'FaceColor', c(m, :));
hold on
axis([0 nx  0 ny  0 0.1])
xlabel('X','FontSize', 12) 
ylabel('Y','FontSize', 12) 
zlabel('Current (A)') 
title('Current with Changing Bottle-neck Width','FontSize', 18);
pause(0.01);
end

%--------------------------------------------------------------------------
figure
plot(sigmaBox, mainCurrentVarSigma * 1000)
title('Current vs \sigma','FontSize', 18)
xlabel('\sigma (1/ \Omega)','FontSize', 12) 
ylabel('Current (mA)','FontSize', 12)

figure
plot(varNx, mainCurrentVarSize * 1000)
title('Current vs Mesh Size','FontSize', 18)
xlabel('Mesh Length (nx)', 'FontSize', 12) 
ylabel('Current (mA)','FontSize', 12)



figure
plot(varLength, mainCurrentVarPassage * 1000)
title('Current vs Bottlneck Length','FontSize', 18)
xlabel('Bottleneck Length', 'FontSize', 12) 
ylabel('Current (mA)','FontSize', 12)


figure
plot(varWidth, mainCurrentVarWidth * 1000)
title('Current vs Bottlneck Width','FontSize', 18)
xlabel('Bottleneck Width', 'FontSize', 12) 
ylabel('Current (mA)','FontSize', 12)




