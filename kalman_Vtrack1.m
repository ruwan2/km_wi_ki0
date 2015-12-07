% 
% 
% 
clear;
% delta_t=0.1;
length = 50;
matrix_F=1;
sigma_a_sq = 1e-5;      
sigma_z_sq = 0.1;      
matrix_Q=sigma_a_sq;
matrix_H=1;      % [1, 0];

hat_x_00=0.0; 
Rconst=-0.37727;
matrix_P=1;
sigma_z = 0.01;
matrix_R = sigma_z;

hat_x_k1_k1 = hat_x_00;
% a_k = 0.1;
x_k = 0;

hat_P_k1_k1 = matrix_P;
for iterator=1:length
figure(4);
    w_k = normrnd(0,  sigma_a_sq);     
    v_k = normrnd(0,  sigma_z_sq);
    x_k = matrix_F * x_k; % + w_k;
    z_k = matrix_H * Rconst + v_k;
    subplot(311);
    hold on;
    plot(iterator, x_k(1,1), '.');
    subplot(312);
    hold on;
    plot(iterator, z_k, '.');
    subplot(313);
    hold on;
    plot(iterator, w_k, '.');
    %% Predict
    hat_x_k_k1 = matrix_F * hat_x_k1_k1; % + matrix_G * a_k;
    hat_P_k_k1 = matrix_F * hat_P_k1_k1 * matrix_F.' + matrix_Q;
figure(5);
    subplot(311);
    hold on;
    plot(iterator, hat_x_k_k1, '.');
    subplot(312);
    hold on;
    plot(iterator, z_k, '.');


    %% Update
    tide_y = z_k - matrix_H * hat_x_k_k1;
    S_k    = matrix_H * hat_P_k_k1 * matrix_H.' + matrix_R;
    K_k    = hat_P_k_k1 * matrix_H.' / S_k;
    hat_x_k1_k1 = hat_x_k_k1 + K_k * tide_y;
    hat_P_k1_k1 = (1 - K_k * matrix_H) * hat_P_k_k1;
    x_k = hat_x_k1_k1;
    subplot(313);
    hold on;
    plot(iterator, S_k, '.');
end
hat_x_k_k1


