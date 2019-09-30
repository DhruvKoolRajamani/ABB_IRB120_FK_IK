%% HW2B
%  
%% q = (50, -45, 30, 20, 10, 0)
% 
% For configuration: 
% 
%   q = (50, -45, 30, 20, 10, 0)
% 
% <<Images\p01.png>>
% 

subplot(1,4,1);
[T] = plotArm(50, -45, 30, 20, 10, 0, f);
subplot(1,4,[2 3 4]);
image(imread('Images\01.png'));
set(gcf, 'Position', get(0, 'Screensize'));

%% q = (10, 50, -45, 20, 10, 0)
% 
% For configuration: 
% 
%   q = (10, 50, -45, 20, 10, 0)
% 
% <<Images\p02.png>>
% 

subplot(1,4,1);
[T] = plotArm(10, 50, -45, 20, 10, 0, f);
subplot(1,4,[2 3 4]);
image(imread('Images\02.png'));
set(gcf, 'Position', get(0, 'Screensize'));

%% q = (50, -45, 30, 50, -20, 40)
% 
% For configuration: 
% 
%   q = (50, -45, 30, 50, -20, 40)
% 
% <<Images\p03.png>>
% 

subplot(1,4,1);
[T] = plotArm(50, -45, 30, 50, -20, 40, f);
subplot(1,4,[2 3 4]);
image(imread('Images\03.png'));
set(gcf, 'Position', get(0, 'Screensize'));

%% q = (-30, -60, 20, 40, -20, 40)
% 
% For configuration: 
% 
%   q = (-30, -60, 20, 40, -20, 40)
% 
% <<Images\p04.png>>
% 

subplot(1,4,1);
[T] = plotArm(-30, -60, 20, 40, -20, 40, f);
subplot(1,4,[2 3 4]);
image(imread('Images\04.png'));
set(gcf, 'Position', get(0, 'Screensize'));

%% q = (0, 32, 45, 30, 56, 40)
% 
% For configuration: 
% 
%   q = (0, 32, 45, 30, 56, 40)
% 
% <<Images\p05.png>>
% 

subplot(1,4,1);
[T] = plotArm(0, 32, 45, 30, 56, 40, f);
subplot(1,4,[2 3 4]);
image(imread('Images\05.png'));
set(gcf, 'Position', get(0, 'Screensize'));

%% Appendix
% 
%%% Plot Arm Function
% 
% <include>plotArm.m</include>
% 
%%% dhparam2matrix Function
% 
% <include>dhparam2matrix.m</include>
% 
%%% fk_solve Function
% 
% <include>fk_solve.m</include>
% 
%%% drawManip Function
% 
% <include>drawManip.m</include>
% 
%%% drawAxisLines Function
% 
% <include>drawAxisLines.m</include>
% 