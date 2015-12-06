% https://en.wikipedia.org/wiki/Kalman_filter#Derivations
% 
% 
clear;
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
% x_k = hat_x_00;
sigma_z = 0.01;
matrix_R = sigma_z^2;

n1 = normrnd(0,1);
hat_x_k1_k1 = hat_x_00;
a_k = 0.1;
x_k = [0; 0];
% noise_size=[length, 1];
noise_size=1;
% w_k = normrnd(0*noise_size,  matrix_Q*noise_size, [length, 1]);     
figure(2);
x_k=[0; 0];
hold off;
hat_P_k1_k1 = matrix_P;
for iterator=1:length
figure(2);
    w_k = normrnd(0,  sigma_a_sq);     
    v_k = normrnd(0,  sigma_z_sq);
    x_k = matrix_F * x_k + w_k;
    z_k = matrix_H * x_k + v_k;
    subplot(311);
    hold on;
    plot(iterator, x_k(1,1), '.');
    subplot(312);
    hold on;
    plot(iterator, x_k(2,1), '.');
    subplot(313);
    hold on;
    plot(iterator, w_k, '.');
    %% Predict
    hat_x_k_k1 = matrix_F * hat_x_k1_k1; % + matrix_G * a_k;
    hat_P_k_k1 = matrix_F * hat_P_k1_k1 * matrix_F.' + matrix_Q;
figure(3);
    hold on;
    plot(iterator, hat_x_k_k1, '.');


    %% Update
    tide_y = z_k - matrix_H * hat_x_k_k1;
    S_k    = matrix_H * hat_P_k_k1 * matrix_H.' + matrix_R;
    K_k    = hat_P_k_k1 * matrix_H.' / S_k;
    hat_x_k1_k1 = hat_x_k_k1 + K_k * tide_y;
    hat_P_k1_k1 = (eye(2) - K_k * matrix_H) * hat_P_k_k1;
end
hat_x_k_k1


