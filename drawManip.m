function [f] = drawManip(Transformations, indTransforms, Name)
%DRAWMANIP Summary of this function goes here
%   Detailed explanation goes here
[l,m,n] = size(Transformations);
f = figure('Name', Name);
az = -165;
el = 11;
rotate3d on
grid on
xlabel('X');
ylabel('Y');
zlabel('Z');
R1 = [1 0 0;
      0 1 0;
      0 0 1];
x = [0, Transformations(1,4,1)];
y = [0, Transformations(2,4,1)];
z = [0, Transformations(3,4,1)];
plot3(x, y, z,'m','LineWidth',3);
hold on
drawAxisLines(f,R1,[0;0;0]); % indTransforms(1:3,1:3,1) Transformations(1:3,4,1)
view(az,el);
axis('equal');
for i = 2:n
    x = [Transformations(1,4,i-1), Transformations(1,4,i)];
    y = [Transformations(2,4,i-1), Transformations(2,4,i)];
    z = [Transformations(3,4,i-1), Transformations(3,4,i)];
%     drawAxisLines(f,indTransforms(1:3,1:3,i),Transformations(1:3,4,i))
    drawAxisLines(f,Transformations(1:3,1:3,i-1),Transformations(1:3,4,i-1));
    plot3(x, y, z,'m','LineWidth',3);
end

drawAxisLines(f,Transformations(1:3,1:3,i),Transformations(1:3,4,i));

hold off
end

