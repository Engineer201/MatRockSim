% ----
% �W����C���f����p�����A���x�ɂ�鉷�x�A�����A��C���A��C���x�̊֐�
% ���x�͊�W�I�|�e���V�������x�����ɂ��Ă���B
% �W����C�̊e�w���Ƃ̋C�����������`����p���Čv�Z���Ă���B
% Standard Atmosphere 1976�@ISO 2533:1975
% ���Ԍ����x86km�܂ł̋C���ɑΉ����Ă���B����ȏ�͍��ەW����C�ɓ��Ă͂܂�Ȃ��̂Œ��ӁB
% cf. http://www.pdas.com/hydro.pdf
% @param h ���x[m]
% @return T ���x[K]
% @return a ����[m/s]
% @return P �C��[Pa]
% @return rho ��C���x[kg/m3]
% 1:	�Η���		���x0m
% 2:	�Η����E��	���x11000m
% 3:	���w��  		���x20000m
% 4:	���w���@ 		���x32000m
% 5:	���w���E�ʁ@	���x47000m
% 6:	���Ԍ��@ 		���x51000m
% 7:	���Ԍ��@ 		���x71000m
% 8:	���Ԍ��E�ʁ@	���x84852m
% ----
% Future Works:
% ATOMOSPHERIC and SPACE FLIGHT DYNAMICS���
% Standard ATOMOSPHERE�̃X�N���v�g�ɕύX���č��x2000km�܂őΉ��ɂ���B
% ��ɉ��x�㏸�Əd�͉����x�ƃK�X�󐔂��ω����邱�ƂɑΉ����邱�ƁB
% ----
function [T, a, P, rho] = atmosphere_Rocket( h )
g = 9.80655;
gamma = 1.4;
R = 287.0531;
% height of atmospheric layer
HAL = [0 11000 20000 32000 47000 51000 71000 84852];
% Lapse Rate Kelvin per meter
LR = [-0.0065 0.0 0.001 0.0028 0 -0.0028 -0.002 0.0];
% Tempareture Kelvin
T0 = [288.15 216.65 216.65 228.65 270.65 270.65 214.65 186.95];
% Pressure Pa
P0 = [101325 22632 5474.9 868.02 110.91 66.939 3.9564 0.3734];

if ( h > HAL(1) && h < HAL(2) )
	k = 1;
elseif ( h > HAL(2) && h < HAL(3) )
	k = 2;
elseif ( h > HAL(3) && h < HAL(4) )
	k = 3;
elseif ( h > HAL(4) && h < HAL(5) )
	k = 4;
elseif ( h > HAL(5) && h < HAL(6) )
	k = 5;
elseif ( h > HAL(6) && h < HAL(7) )
	k = 6;
elseif ( h > HAL(7) && h < HAL(8) )
	k = 7;
elseif ( h > HAL(8))
	k = 8;
else
	k = 1;
end

T = T0(k) + LR(k) .* (h - HAL(k));
a = sqrt( T * gamma * R);
if LR(k) ~= 0
	P = P0(k) .* ((T0(k) + LR(k) *(h - HAL(k))) / T0(k)) .^ (g / -LR(k) / R);
else
	P = P0(k) .* exp(g / R * (HAL(k) - h) / T0(k));
end
rho = P / R / T;
