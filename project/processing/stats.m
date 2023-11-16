% stats.m
load("stats.mat");
numFrames = 372;
norms = zeros(1,11);
seps = [60,30,20,15,12,10,6,4,3,2,1];
frames = ceil(numFrames ./ seps);
reshaping_times = [0.5309, 0.9771, 1.3932, 1.8814, 2.2850, 2.7997, 4.5831, 6.9428, 9.5712, 13.9906, 30.9990];
svd_times = [475.0731, 111.8153, 46.9659, 24.5355, 18.3275, 16.9817, 23.1545, 37.4466, 56.0710, 90.9293, 232.4547];
total_times = reshaping_times + svd_times;

background = imread("./photos/shark_1.png");
norm_background = norm(double(background), "fro");
errors = zeros(1,11);
for i=1:11
    curr_img = imread(sprintf("./results/shark_result_sep%d.png", seps(i)));
    errors(i) = 100 * norm(double(background - curr_img), "fro") / norm_background;
end

tiledlayout(2,1)
% Top plot
ax1 = nexttile;
plot(ax1,frames,svd_times,'b.--',frames,total_times,'k.-',frames,reshaping_times,'b.:',MarkerSize=10);
xlabel("Number of Used Frames (total=372)");
ylabel("Time (s)");
% Bottom plot
ax2 = nexttile;
plot(ax2,frames,errors,'k.-',MarkerSize=10);
xlabel("Number of Used Frames (total=372)");
ylabel("Relative Error (Frob., %)");
%{
index_vector = 1:min(m,n);
plot(index_vector, norms(:,:,1), 'r-', index_vector, norms(:,:,2), 'g-', index_vector, norms(:,:,3), 'b-');
title(['LRA of ',img_name,img_ext]);
xlabel('Approximation Rank');
ylabel(norm_name);
grid on;
%}
