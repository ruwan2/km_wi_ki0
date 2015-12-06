% https://en.wikipedia.org/wiki/Kalman_filter#Derivations
% 
% 
delta_t=0.1;
length = 200;
matrix_F=[1, delta_t; ...
          0, 1];
matrix_G=[delta_t^2/2; ...
          delta_t];
sigma_a_sq = 0.1;      
sigma_z_sq = 0.12;      
matrix_Q=[delta_t^4/4, delta_t^3/2; ...
          delta_t^3/2, delta_t^2]*sigma_a_sq;
% w_k = normrnd(0,  matrix_Q);     
matrix_H=[1, 0];

hat_x_00=zeros(2,1);
matrix_P=zeros(2,2);

sigma_z = 0.01;
matrix_R = sigma_z^2;

n1 = normrnd(0,1);
hat_x_k1_k1 = hat_x_00;
a_k = 0.1;

% noise_size=[length, 1];
noise_size=1;
% w_k = normrnd(0*noise_size,  matrix_Q*noise_size, [length, 1]);     
% w_k = normrnd(0*noise_size,  matrix_Q*noise_size, [length, 1]);     
% v_k = normrnd(0,  matrix_R, [length, 1]);
hat_P_k1_k1 = matrix_P;
figure(1);
x_k=0;
hold off;
for iterator=1:length
    w_k = normrnd(0,  matrix_Q);     
    v_k = normrnd(0,  matrix_R);
    x_k = matrix_F * x_k + w_k;
    z_k = matrix_H * x_k + v_k;
    subplot(211);
    hold on;
    plot(iterator, x_k(1,1), '*');
    subplot(212);
    hold on;
    plot(iterator, x_k(2,2), '*');
end
hat_x_k_k1


