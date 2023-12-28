% test.m

SIZE = 500;
MATRIX_TYPE = "single";

fprintf("Start Initializing...\n");
tic;
background = zeros(SIZE^2, SIZE, MATRIX_TYPE);
A = zeros(SIZE^2, SIZE, MATRIX_TYPE);
fprintf("Finish Initializing! (%.02f sec.)\n\n", toc);

fprintf("Start Genetating Random Matrices...\n");
tic;
for i=1:SIZE
    temp = rand(SIZE, SIZE, MATRIX_TYPE);
    background(SIZE*i-SIZE+1:SIZE*i,:) = temp;
    A(SIZE*(i-1)+1:SIZE*i,:) = temp;
    A(SIZE*i,i) = 0;
end
fprintf("Finish Generating Random Matrices! (%.02f sec.)\n\n", toc);

fprintf("Starting Calculating Low Rank Approximation...\n");
tic;
A_main = one_sv_lr_approx(A);
fprintf("Finish Calculating Low Rank Approximation! (%.02f sec.)\n\n", toc);

fprintf("Starting Calculating Errors...\n");
tic;
err_1 = norm(A - A_main, "fro") / norm(double(A), "fro");
err_2 = norm(A - background, "fro") / norm(double(A), "fro");
fprintf("error 1 = %.08f\n", err_1);
fprintf("error 2 = %.08f\n", err_2);
fprintf("Finish Calculating Errors! (%.02f sec.)\n\n", toc);

function result = one_sv_lr_approx(A)
    [U, S, V] = svd(A, "econ");
    V_conj = V';
    result = S(1,1) * U(:,1) * V_conj(1,:);
end