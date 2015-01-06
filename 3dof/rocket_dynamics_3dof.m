% ----
% ode�̂��߂̃��P�b�g���Ă̏�����������B���i��3���R�x�ɕύX���Ă���B
% �ʒu�Ǝp�������߂邽�߂ɁA�u�ʒu�A���x�A�p���A�p���x�v����ԗʂɁB
% 
% ����Ă邱��
% �@�̂ɂ����鐄�́A��C�́A�d�͂̎Z�o 
% -> �@�̂ɂ����郂�[�����g�̎Z�o
% -> �ʒu�̉^���������A���x�̉^���������A�p���̉^���������A�p���x�̉^��������
% 
% �������W�n�̎�����xyz�̏��Ԃ�Up-East-North
% ----
function [ dx ] = rocket_dynamics_3dof( t, x )
% x(1): mass ����[kg]
% x(2): X_H �˓_���W�ʒu[m]
% x(3): Y_H �˓_���W�ʒu[m]
% x(4): Z_H �˓_���W�ʒu[m]
% x(5): VX_H �˓_���W�Βn���x[m/s]
% x(6): VY_H �˓_���W�Βn���x[m/s]
% x(7): VZ_H �˓_���W�Βn���x[m/s]
% ----

global ROCKET
global VWH

% ROCKET�\���̂���ϐ��ǂݎ��
Isp = ROCKET.Isp;
g0 = ROCKET.g0;
FT = ROCKET.FT;
Tend = ROCKET.Tend;
CLa = ROCKET.CLa;
Area = ROCKET.Area;

% ---- ���� ----
% �W���o���p�x delta_Y, delta_P[rad]
deltaY = 0;
deltaP = 0;

% ��C�� P[Pa] ��C���x rho[kg/m3]
% P = 101325;
% rho = 1.2;
[~, a, P, rho] = atmosphere_Rocket(x(2));

% ��i���� FT[N] ���̎����ɂ����鐄�� Ft[N]
% ���i�܂̎��ʗ��� delta_m[kg/s]
Ft = thrust(t, [Tend], [FT]); 
delta_m = -Ft / Isp / g0;

% �W���o���p���l�������@�̍��W�n�ɂ����鐄�� FTB[N]
FTB = Ft * [cos(deltaY)*cos(deltaP); -sin(deltaY); -cos(deltaY)*sin(deltaP)];

% =====
% �p���p��target_angle���玝���Ă���
% =====
qB2H = target_angles(t);

% ---- ��C�� ----
% �������W�n�ɂ����镗�x�N�g��VWH[m/s]�i���x�����̕��z�͖������̂Ƃ���j
% �������W�n�ɂ�����@�̂̑΋C���x�x�N�g��VA[m/s]
VWH = [0; 0; 0];
VA = [x(5); x(6); x(7)] - VWH; % �΋C���x

% �@�̍��W�n���琅�����W�n�ւ̍��W�ϊ���\���N�H�[�^�j�I�� quat (quat_B2H)
% quat = [x(8) x(9) x(10) x(11)]; % q_B2H
quat = qB2H;

% �@�̍��W�n����݂����x�x�N�g��VAB�����߂đ��x���W�n�̒�`����
% �@�̍��W�n����݂����x���W�n�̊��x�N�g��[xAB yAB zAB]�����Ƃ߂�
% ���x���W�n����@�̍��W�n�ւ̕����]���s��DCM_A2B�����߂Ă���B
% �@�̍��W�n�ɂ������C�� FAB[N]
if norm(VA) == 0.0
  xAB = [1; 0; 0]; % �@�̍��W�n���x�����P�ʃx�N�g��
  VAB = [0; 0; 0];
else
  qVAB = quatmultiply(quat, quatmultiply([0 VA'], quatinv(quat)));
  VAB = qVAB(2:4)';
  xAB = VAB / norm(VAB);
end
yABsintheta = cross(xAB, [1; 0; 0]);
sintheta = norm(yABsintheta);
if sintheta == 0.0
  yAB = [0; 1; 0];
else
  yAB = yABsintheta / sintheta;
end
theta = asin(sintheta);
zAB = cross(xAB, yAB);

% ���x���W�n����݂���C�� FAA[N]
CD = cd_Rocket(norm(VAB) / a);
FAA = -0.5*rho*norm(VA)^2*Area*[CD; 0; CLa * theta];
% FAA = -0.5*rho*norm(VA)^2*area*[CD; 0; CLa * theta];

DCM_A2B = [xAB yAB zAB];
FAB = DCM_A2B * FAA;

% ---- �d�� ----
% �������W�n�ɂ�����@�̂ɂ�����d�� FHG[N]
[gc, gnorth] = gravity(x(2), 35*pi/180);
FGH = x(1) * [gc; 0; gnorth];

% ---- ���x�^�������� ----
qFTAH = quatmultiply(quatinv(quat),quatmultiply([0 (FTB+FAB)'], quat));
FTAH = qFTAH(2:4)';
delta_V = 1/x(1)*(FTAH + FGH);

dx = [ delta_m;
x(5);
x(6);
x(7);
delta_V(1);
delta_V(2);
delta_V(3)];

end
