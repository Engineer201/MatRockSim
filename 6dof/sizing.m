close all

Isp = 170:10:180;
div = 4;
% output = zeros(length(Isp),div);
weight_dry = zeros(length(Isp), div);
weight_prop = zeros(length(Isp), div);
weight_all = zeros(length(Isp), div);
massratio = zeros(length(Isp), div);
for i = 1:length(Isp)
    [weight_dry(i,:), weight_prop(i,:), ...
        weight_all(i,:), massratio(i,:)] = sizing_plot(Isp(i), 0.4);
    
%     weight_dry = output(1,:);
%     weight_prop = output(2,:);
%     weight_all = output(3,:);
%     massratio = output(4,:);
end

figure(1);
plot(weight_dry', weight_all');
title('Dry Weight vs Total Weight')
xlabel('Dry Weight (kg)')
ylabel('Total Weight (kg)')
grid on

figure(2)
plot(weight_dry', weight_prop');
title('Dry Weight vs Propulsion Weight')
xlabel('Dry Weight (kg)')
ylabel('Propulsion Weight (kg)')
grid on

figure(3)
plot(weight_dry', massratio');
title('Dry Weight vs Mass ratio')
xlabel('Dry Weight (kg)')
ylabel('Mass ratio (-)')
grid on
