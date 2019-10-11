%% Homework 3A
%
%% Frame Assignment
%
im = imread('frames.PNG')
imshow(im)
snapnow
%% DH Parameters
% 
im = imread('dh.PNG')
imshow(im)
snapnow
%% Forward Kinematics
%
clear all, clc, close all

syms q1 q2 q3 a b c d e f g r dq1 dq2 dq3 pi

vals = 0;

q = [0 q1 q2 q3 0].';
dq = [0 dq1 dq2 dq3 0].';

dofs = 5;

unit = symunit;
thetas = ([0 (pi/2)-q1 -q2 (pi/2)-q3 0].')*unit.radian;
d = [b+d 0 0 0 g].';
a = [-c e f 0 0].';
alpha = ([pi/2 0 0 pi/2 0].')*unit.radian;

[Transforms, T] = plotArm(q, thetas, d, a, alpha, 'Neobotic', vals, [0 -90 0], false);
T

%% Forward Velocity Kinematics
%
[Jv, Jw, p, z] = calcJacobian(Transforms,q,'prrrp',vals);

J = subs([Jv(:,:,dofs);Jw(:,:,5)],pi,double(pi));
J

dx = J*dq;
dx

%% Reduced J
J_simplified = [J(1,2:4);J(3,2:4);J(5,2:4)];
J_simplified

%% Force Propagation
%
syms Fx Fy Fz Mx My Mz T1 T2 T3

Tau = [0 T1 T2 T3 0].';
F = [Fx Fy Fz Mx My Mz].';

Tau = (J.')*F;
Tau

%% Numeric Solution
%
clear all, clc, close all
syms q1 q2 q3 dq1 dq2 dq3 pi % a b c d e f g r 

a=507;
b=424;
c=300;
d=380;
e=328;
f=323;
g=82.4;
r=143;

vals = [0,pi/6,pi/2,pi/4,0].';
q = [0 q1 q2 q3 0].';
dq = [0 dq1 dq2 dq3 0].';

dofs = 5;

unit = symunit;
thetas = ([0 (pi/2)-q1 -q2 (pi/2)-q3 0].')*unit.radian;
d = [b+d 0 0 0 g].';
a = [-c e f 0 0].';
alpha = ([pi/2 0 0 pi/2 0].')*unit.radian;

%% Numeric Forward Position Kinematics
%
[Transforms, T] = plotArm(q, thetas, d, a, alpha, 'Neobotic', vals, [0 -90 0], false);
T
hold off
x_init = T(1:3,4);
axis([-500 500 -500 500 0 1200])
drawnow

%% Numeric Instantaneous Tip Velocity
% 
[Jv, Jw, p, z] = calcJacobian(Transforms,q,'prrrp',vals);

J = double(subs([Jv(:,:,dofs);Jw(:,:,5)],[q;pi],[vals;double(pi)]))
% Reduced J
J_simplified = [J(1,2:4);J(3,2:4);J(5,2:4)]

dx = double(subs(J*dq,dq,[0;20;20;20;0]*pi/180));
dx

%% Numeric Arm Joint Torques
% 
syms Fx Fy Fz Mx My Mz T1 T2 T3

Tau = [0 T1 T2 T3 0].';
F = [50 0 0 0 0 0].';

Tau = (J.')*F;
Tau

%% Inverse Velocity Kinematics
%
dx = [0 -100 0].';
dq = J_simplified\dx;
dq

%% Simulated Motion
%

% Getting symbolic Jacobian
[Jv_sym, Jw_sym, p_sym, z_sym] = calcJacobian(Transforms,q,'prrrp',0);
J_sym = [Jv_sym(:,:,dofs);Jw_sym(:,:,dofs)];
joint = vals;
step = 0.1;
x = x_init;
x_fin = x_init - [0;0;10];
i = 1;
while abs(x_fin(3,1) - x(3,1)) <= 100
    x = x + [0;0;-100*step];
    joint = joint + [0; dq*step; 0];
    j_plot(:,i) = joint(2:4);
    i = i+1;
    plotArm(q, thetas, d, a, alpha, 'Neobotic', joint, [0 -90 0], false);
    hold off
    axis([-500 500 -500 500 0 1200])
    drawnow
    pi = double(pi);
    joint = double(subs(joint));
    J_step = double(subs(J_sym,q,joint));
    J_step_sim = [J_step(1,2:4);J_step(3,2:4);J_step(5,2:4)];
    dq = J_step_sim\dx;
end
hold on
plotArm(q, thetas, d, a, alpha, 'Neobotic', vals, [0 -90 0], false);

figure
for j=1:(i-1)
    subplot(3,1,1)
    xlabel('time')
    ylabel('joint 1')
    plot(j,j_plot(1,j), 'ro', 'markersize', 2);
    hold on
    
    subplot(3,1,2)
    xlabel('time')
    ylabel('joint 2')
    plot(j,j_plot(2,j), 'ro', 'markersize', 2)
    hold on
    
    subplot(3,1,3)
    xlabel('time')
    ylabel('joint 3')
    plot(j,j_plot(3,j), 'ro', 'markersize', 2)
    hold on
end