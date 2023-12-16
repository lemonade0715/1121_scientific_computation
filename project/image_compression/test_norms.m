% test_norms.m

%
norm_type_enum = {1, 2, inf, 'fro'};
norm_name_enum = {'1-', '2-', 'Infinity ', 'Frobenius '};
init = 500;
samples = 10;
stats = zeros(samples, 4);

for i=1:length(norm_name_enum)
    fprintf("\n[%snorm]\n", norm_name_enum{i});
    for j=1:samples
        fprintf("Calculating sample %d...\n",j);
        A = rand(init*j,init*j);
        tic;
        norm(A, norm_type_enum{i});
        stats(j,i) = toc;
    end
end
disp(stats);
%}

%{
norm_type_enum = {1, 2, inf, 'fro'};
norm_name_enum = {'1-', '2-', 'Infinity ', 'Frobenius '};
stats = zeros(1, 4);

for i=1:length(norm_name_enum)
    fprintf("\n[%snorm]\n", norm_name_enum{i});
    A = rand(30720,17820);
    tic;
    norm(A, norm_type_enum{i});
    stats(i) = toc;
end
disp(stats);
%}

% Plot the values
%{
index_vector = init:init:init*samples;
plot(index_vector, stats(1,:), 'r-', index_vector, stats(2,:), 'g-', index_vector, stats(3,:), 'b-', index_vector, stats(4,:), 'c-');
title('Runtime of Matrix Norms');
xlabel('Random Matrix Size');
ylabel('(sec)');
grid on;
%}