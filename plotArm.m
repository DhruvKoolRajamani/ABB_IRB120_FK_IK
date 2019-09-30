function [T] = plotArm(val1, val2, val3, val4, val5, val6, f)

syms q1 q2 q3 q4 q5 q6
q = [q1 q2 q3 q4 q5 q6].';
vals = [val1 val2 val3 val4 val5 val6].';
[n_dof,m] = size(q);
Individual_Transforms = sym(zeros(4,4,n_dof));
Transforms = sym(zeros(4,4,n_dof));

thetas = q;
thetas(2,1) = q2 - 90;
thetas(6,1) = q6 + 180;
d = [290 0 0 302 0 72].';
a = [0 270 70 0 0 0].';
alpha = [-90 0 -90 90 -90 0].';

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

T01 = Individual_Transforms(:,:,1);
T12 = Individual_Transforms(:,:,2);
T23 = Individual_Transforms(:,:,3);
T34 = Individual_Transforms(:,:,4);
T45 = Individual_Transforms(:,:,5);
T56 = Individual_Transforms(:,:,6);

T06 = Transforms(:,:,6);

solution = double(simplify(fk_solve(Transforms, q, vals, 0)));
T = solution(:,:,6)
indTransforms = double( ...
                    simplify(fk_solve(Individual_Transforms, q, vals, 0)));

f = drawManip(solution, indTransforms, 'ABB_Robot');

end

