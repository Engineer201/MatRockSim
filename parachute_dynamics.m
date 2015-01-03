% ----
% cd http://airex.tksc.jaxa.jp/dr/prc/japan/contents/NALTM0368000/naltm00368.pdf
% ----

function [ dx ] = parachute_dynamics( t, x )
% x(1): mass ����[kg]
% x(2): X_H �˓_���W�ʒu[m]
% x(3): Y_H �˓_���W�ʒu[m]
% x(4): Z_H �˓_���W�ʒu[m]
% x(5): VX_H �˓_���W�Βn���x[m/s]
% x(6): VY_H �˓_���W�Βn���x[m/s]
% x(7): VZ_H �˓_���W�Βn���x[m/s]
% x(8): q0 quaternion Body to Horizon[-]
% x(9): q1 quaternion Body to Horizon[-]
% x(10): q2 quaternion Body to Horizon[-]
% x(11): q3 quaternion Body to Horizon[-]
% x(12): omegaX �@�̍��W�n�̊p���x[rad/s]
% x(13): omegaY �@�̍��W�n�̊p���x[rad/s]
% x(14): omegaZ �@�̍��W�n�̊p���x[rad/s]
% ----

% �p���V���[�g���a�A�ʐρA�R�͌W��
global VWH
global para_Cd para_S

% ��C���x�A�d�͉����x
[~, a, P, rho] = atmosphere_Rocket(x(2));
[gc, gnorth] = gravity(x(2), 35*pi/180);

% ���x�̉^��������
if x(5) > 0
	delta_V = gc - 0.5 / x(1) * rho * para_Cd * para_S * x(5) * x(5);
else
	delta_V = gc + 0.5 / x(1) * rho * para_Cd * para_S * x(5) * x(5);
end

dx = [ 0.0;
x(5);
VWH(2);
VWH(3);
delta_V;
0;
0;
0;
0;
0;
0;
0;
0;
0];

end