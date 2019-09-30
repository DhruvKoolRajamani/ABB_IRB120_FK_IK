%% ABB IRB 120 Robot
% This program simulates the forward kinematics of an ABB IRB 120 robot.
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 
clc
clear all
syms q1 q2 q3 q4 q5 q6

%% Question 1
% On a line drawing of the robot (such as from the figure below of the
% manual), define and label coordinate frames for the base, each link, and the
% tip. You should do this using the D-H convention from this class. Clearly
% show the location of the origin and the direction for each axis of each frame
% that you define. Be sure to use the axis numbering, base & tool frame, and
% rotation direction conventions provided for the robot and matching that of
% the simulation. As previously noted, you are expected to use the D-H
% convention presented in this class – some other references may have
% variants in indexing that can cause confusion so be careful with outside
% references & examples
% 
% <html>
% <table>
% <tr>
% <th>q</th>
% <th><span style="font-weight:bold;font-style:italic">theta</span></th>
% </tr>
% <tr>
% <td>q1</td>
% <td>theta1</td>
% </tr>
% <tr>
% <td>q2</td>
% <td>theta2</td>
% </tr>
% <tr>
% <td>q3</td>
% <td>theta3</td>
% </tr>
% <tr>
% <td>q4</td>
% <td>theta4</td>
% </tr>
% <tr>
% <td>q5</td>
% <td>theta5</td>
% </tr>
% <tr>
% <td>q6</td>
% <td>theta6</td>
% </tr>
% </table>
% </html>
% 
% <<../Images/IRB_W_FRAMES.PNG>>
%
% Declaring various variables. The final transformation matrices for the n 
% dofs with respect to the origin of the manipulator are stored in every 
% successive nth space of the _4x4xn_ matrix *Transforms*. Similarly the final
% transformation matrices for the n dofs with respect to the n-1th frame
% are stored in every successive nth space of the _4x4xn_ matrix
% *Individual_Transforms*.
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 

global n_dof;
q = [q1 q2 q3 q4 q5 q6].';
[n_dof,m] = size(q);
Individual_Transforms = sym(zeros(4,4,n_dof));
Transforms = sym(zeros(4,4,n_dof));

%% Question 2
% Determine the D-H parameters for the robot and show a clearly
% labeled table. Be sure to include units, identify the joint variables, and
% check your joint directions. Generate Matlab variables for each of the 4
% parameters as nx1 vectors.
% 
% <html>
% <table>
%   <tr>
%     <th><span style="font-style:italic">n</span></th>
%     <th><span style="font-weight:bold">theta</span></th>
%     <th>d</th>
%     <th>a</th>
%     <th>alpha</th>
%   </tr>
%   <tr>
%     <td>1</td>
%     <td>q1</td>
%     <td>290</td>
%     <td>0</td>
%     <td>-90</td>
%   </tr>
%   <tr>
%     <td>2</td>
%     <td>q2-90</td>
%     <td>0</td>
%     <td>270</td>
%     <td>0</td>
%   </tr>
%   <tr>
%     <td>3</td>
%     <td>q3</td>
%     <td>0</td>
%     <td>70</td>
%     <td>-90</td>
%   </tr>
%   <tr>
%     <td>4</td>
%     <td>q4</td>
%     <td>302</td>
%     <td>0</td>
%     <td>90</td>
%   </tr>
%   <tr>
%     <td>5</td>
%     <td>q5</td>
%     <td>0</td>
%     <td>0</td>
%     <td>-90</td>
%   </tr>
%   <tr>
%     <td>6</td>
%     <td>q6</td>
%     <td>72</td>
%     <td>0</td>
%     <td>0</td>
%   </tr>
% </table>
% </html>
% 
% The following section shows the DH Parameters in vector form.
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 

thetas = q;
thetas(2,1) = q2 + 90;
thetas
d = [290 0 0 302 0 72].'
a = [0 270 70 0 0 0].'
alpha = [90 0 -90 90 -90 0].'

%% Question 3
%%% a) 
% Create a Matlab function that takes a set of DH parameters (each of
% the 4 parameters as an nx1 vector) for a link and returns a 4x4
% homogeneous transformation matrix using the following syntax
% 
%   T = dhparam2matrix(theta, d, a, alpha)
% 
% <include>dhparam2matrix.m</include>
% 
%%% b) 
% Write a loop that goes through all n links to generate the respective
% corresponding transformation matrix
% 
% A for loop adds the transformation of each frame wrt previous frames to a
% n dimension 4x4 matrix called Individual_Transforms and the 
% transformation of each frame wrt the base frame to a n dimensional 4x4 
% matrix called Transforms.
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 
for i = 1:n_dof
    Individual_Transforms(:,:,i) = ...
                dhparam2matrix(thetas(i,1), d(i,1), a(i,1), alpha(i,1));
    if i == 1
        Transforms(:,:,1) = Individual_Transforms(:,:,1);
    else
        Transforms(:,:,i) = ...
                Transforms(:,:,i-1)*Individual_Transforms(:,:,i);
    end
end

%%% c) 
% Show the symbolic 4x4 SE(3) transformation matrices corresponding
% to each of the intermediate transformations. 
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 
T01 = Individual_Transforms(:,:,1)
T12 = Individual_Transforms(:,:,2)
T23 = Individual_Transforms(:,:,3)
T34 = Individual_Transforms(:,:,4)
T45 = Individual_Transforms(:,:,5)
T56 = Individual_Transforms(:,:,6)

%% Question 4
% Solve for the composite transformation representing the forward
% kinematics from base to tip ( T0n ). Be sure to show your work and 
% simplify the solution as much as possible. This will be a large symbolic 
% 4x4 matrix.
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 
T06 = Transforms(:,:,6)

%% Question 5
% Plug into the answer for Problem 4 the home/zero joint
% configuration 
% 
%   [0, 0, 0, 0, 0, 0] 
% 
% as shown in the figure below. Show the numeric 4x4 homogeneous 
% transformation matrix representing the 6-DOF pose tip frame with respect 
% to the base frame. Check that the rotation matrix and the x,y,z offset 
% directions match what you would have expected by inspection of the figure 
% below.
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 
% <<..\Images\home.png>>
% 
% The following function solves this equation while constraining the
% equation to the joint limits.
% *ALL UNITS USED ARE IN MM AND DEGREES*
%
T = plotArm(0, 0, 0, 0, 0, 0);

%% Question 6
% For the following joint configuration 
% 
%     [-45, 30, -30, -30, -45, 180], 
% 
% determine the forward kinematics of the end effector (configuration
% shown below). These values represent the angles with respect to the
% previous link as we typically use in class. 
% 
%%% a) 
% Determine the numeric 4x4 homogeneous transformation matrix representing 
% the tool’s pose (tip frame) with respect to the base frame for this joint
% configuration. 
% 
% <<..\Images\special_rotation.PNG>>
% 
% *ALL UNITS USED ARE IN MM AND DEGREES*
% 
[T] = plotArm(-45, 30, -30, -30, -45, 180, f);