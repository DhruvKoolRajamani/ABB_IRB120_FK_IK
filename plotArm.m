function [Transforms, T] = plotArm(q, thetas, d, a, alpha, name, vals, ax, runsim)

plot_flag = true;
[vm, vn] = size(vals);
if vm <= 2
    plot_flag = false;
end

[n_dof,m] = size(q);
Individual_Transforms = sym(zeros(4,4,n_dof));
Transforms = sym(zeros(4,4,n_dof));

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

T = Transforms(:,:,n_dof);

if plot_flag
    solution = double(simplify(fk_solve(Transforms, q, vals, 0)));
    T = solution(:,:,n_dof);
    
    if runsim
        Transforms = solution;
    end
    
    indTransforms = double( ...
                    simplify(fk_solve(Individual_Transforms, q, vals, 0)));
    f = drawManip(solution, ax);
end

end

