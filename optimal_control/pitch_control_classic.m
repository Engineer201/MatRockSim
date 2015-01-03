clear all
close all
% ----Constant----
% g: �d�͉����x(m/s2)
% mass: �d��(kg)
% force_t: ����(N)
% L_alpha:
% length_A: ��͒��S�܂ł̋���(m)
% length_T: �W���o���_�܂ł̋���(m)
% theta0: �ڕW�p(������������̊p�x)(deg)
% vel_A: �@���������x(m/s)
% Iyy: �s�b�`�ʕ����̊������[�����g(kg*���Q)
% muA: ��͍�
% muT: ���͍�
% ----------------
g = 9.8066;
mass = 70;
force_T = 1000;
L_alpha = 30;
length_A = 0.2;
length_T = 1.5;
theta0 = 0;
vel_A = 10;
Iyy = 84;

muA = L_alpha * length_A / Iyy;
muT = force_T * length_T / Iyy;

% ----�u���b�N���}----
% ����v�����gP�`�B�֐�: sys_pitch
% PID�R���g���[��K�`�B�֐�: sys_control
% Kp,Kd,Ki: P����W���AD����W���AI����W��
% sys_control = (Kd*s^2 + Kp*s + Ki) / s
% �ꏄ�`�B�֐�L: sys_loop
% ���[�v�`�B�֐�: sys
%   u     +-----------+ y1  u2+---------+     y
%  ------>|sys_control|------>|sys_pitch|------->
%      |  +-----------+       +---------+  |
%      |                                   |
%      |             +------+              |
%      +-------------|  1   |<-------------+
%                    +------+
% ----------------
sys_pitch_num = [muT L_alpha*muT/mass/vel_A*(1+length_A/length_T)]
sys_pitch_den = [1 L_alpha/mass/vel_A -muA muA*g*cos(deg2rad(theta0))/vel_A]
sys_pitch = tf(sys_pitch_num, sys_pitch_den)

Kp = 1;
Kd = 2;
Ki = 0.5;
sys_control = tf([Kd Kp Ki],[1 0])

sys_loop = series(sys_control, sys_pitch)
sys = feedback(sys_loop,[1])

% ----�}��
t = 0:0.01:10;
figure()
bode(sys_pitch,t)
print ('PID_PlantBode.jpg')

figure()
bode(sys_control)
print ('PID_ControllerBode.jpg')

figure()
bode(sys)
print ('PID_FeedbackLoopBode.jpg')
figure()
impulse(sys,t)
print ('PID_impulse_response.jpg')
figure()
t = 0:0.01:10;
u = linspace(0.1,0.1,length(t));
lsim(sys,u,t)
print ('PID_step_response.jpg')

% ----���萫�m�F----
figure()
rlocus(sys)
print ('PID_rlocus.jpg')

figure()
nyquist(sys)
print ('PID_nyquist.jpg')

% % ----cf.PID�R���g���[���̍œK����� ----
% % PID: K(s+a)^2/s �Ƃ���
% % ---------------------------------
% t = 0:0.01:8;
% for K = 0:0.1:10;
% 	for a = 0:0.1:10;
% 		sys_control = tf([K 2*a*K a^2],[1 0]);
% 		sys_loop = series(sys_control, sys_pitch);
% 		sys = feedback(sys_loop,[1]);
% 		y = step(sys,t);
% 		m = max(y);
% 		if m < 1.5 & m > 1.10;
% 			break;
% 		end
% 	end
% 	if m < 1.5 & m > 1.10;
% 		break;
% 	end
% end
% solution = [K a m]
% plot(t,y)
