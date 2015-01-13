close all

global ROCKET

addpath ../quaternion
addpath ../environment
addpath ../aerodynamics
addpath ../mapping
addpath ../gpssim
addpath ..
tic;
% Isp = 170:10:240;
% Isp = 170:10:240;
Isp = 220;
div = 30;
rocket_dia = 0.4;
% thrust = 2000:1000:150000;
thrust = 4000:1000:12000;
length_thrust = length(thrust);
weight_dry = zeros(length_thrust, div);
weight_prop = zeros(length_thrust, div);
weight_all = zeros(length_thrust, div);
massratio = zeros(length_thrust, div);
weight_tank2 = zeros(length_thrust, div);
Isp_legend = zeros(length_thrust, 1);
burn_time_array = zeros(length_thrust, div);
for i = 1:length_thrust
%     ROCKET.FT = thrust(i);
%     [weight_dry(i,:), weight_prop(i,:), ...
%         weight_all(i,:), massratio(i,:), ...
%         burn_time_array(i,:)] = sizing_plot(Isp(i), rocket_dia);
    [weight_dry(i,:), weight_prop(i,:), ...
        weight_all(i,:), massratio(i,:), ...
        burn_time_array(i,:)] = sizing_plot_thrust(thrust(i), rocket_dia);
    
    for j = 1:div
        weight_tank2(i,j) = weight_tank(weight_prop(i,j), rocket_dia / 2);
    end
%     Isp_legend(i) = Isp(i);
%     Isp_legend(i) = thrust(i);
end

% ------------
%     plot 
% ------------
str_dia = num2str(rocket_dia*1000);
% str_thrust = num2str(ROCKET.FT);
str_thrust= 'param';

% ====
Isp_legend = num2str(thrust');
figure(1);
plot(weight_dry', weight_all');
title('�����d�� vs �S���d��')
xlabel('�����d�� (kg)')
ylabel('�S���d�� (kg)')
ylim([0 inf]);
legend(Isp_legend, 'Location', 'Best');
grid on
f1_name = strcat('�O�`', str_dia, 'mm ����', str_thrust, 'N�̑S���d��'); 
f1_dir = strcat('output\', f1_name, '.png');
print(f1_dir, '-dpng', '-r300');

figure(2)
plot(weight_dry', weight_prop');
title('�����d�� vs ���i�܏d��')
xlabel('�����d�� (kg)')
ylabel('���i�܏d�� (kg)')
ylim([0 inf]);
legend(Isp_legend, 'Location', 'Best');
grid on
f1_name = strcat('�O�`', str_dia, 'mm ����', str_thrust, 'N�̐��i�܏d��'); 
f1_dir = strcat('output\', f1_name, '.png');
print(f1_dir, '-dpng', '-r300');

figure(3)
plot(weight_dry', massratio');
title('�����d�� vs ���ʔ�')
xlabel('�����d�� (kg)')
ylabel('���ʔ� (-)')
legend(Isp_legend, 'Location', 'Best');
ylim([1 inf]);
grid on
f1_name = strcat('�O�`', str_dia, 'mm ����', str_thrust, 'N�̎��ʔ�'); 
f1_dir = strcat('output\', f1_name, '.png');
print(f1_dir, '-dpng', '-r300');

figure(4);
x = min(weight_dry(1,:)):max(weight_dry(1,:));
plot(weight_dry', weight_tank2', x, x);
title('�^���N�d�� vs �����d��')
xlabel('�����d�� (kg)')
ylabel('�d�� (kg)')
ylim([0 inf]);
legend(Isp_legend, 'Location', 'Best');
grid on
f1_name = strcat('�O�`', str_dia, 'mm ����', str_thrust, 'N�̃^���N�d��'); 
f1_dir = strcat('output\', f1_name, '.png');
print(f1_dir, '-dpng', '-r300');

figure(5);
plot(weight_dry', weight_all' - weight_tank2' - weight_prop');
title('(�S���d��) - (���i�܁{�^���N�̏d��) = �^���N�E���i�܈ȊO�̏d�ʗ]�T')
xlabel('�����d�� (kg)')
ylabel('�d�� (kg)')
legend(Isp_legend, 'Location', 'Best');
grid on
f1_name = strcat('�O�`', str_dia, 'mm ����', str_thrust, 'N�̏d�ʗ]�T'); 
f1_dir = strcat('output\', f1_name, '.png');
print(f1_dir, '-dpng', '-r300');

figure(6);
plot(weight_dry', burn_time_array');
title('�����d�� vs �R�Ď���')
xlabel('�����d�� (kg)')
ylabel('�R�Ď��� (sec)')
legend(Isp_legend, 'Location', 'Best');
grid on
f1_name = strcat('�O�`', str_dia, 'mm ����', str_thrust, 'N�̔R�Ď���'); 
f1_dir = strcat('output\', f1_name, '.png');
print(f1_dir, '-dpng', '-r300');

toc;