% ---- �O���[�o���ϐ��̐ݒ�i������Ȃ��j ----
global Isp g0
global FT Tend At CLa area
global length_GCM length_A
global IXX IYY IZZ
global IXXdot IYYdot IZZdot

% ---- �p�����[�^�ݒ� ----
% m0: ��������[kg]
% Isp: �䐄��[sec]
% g0: �n��ł̏d�͉����x[m/s2]
% FT: ����[N]
% Tend: �R�Ď���[sec]
% At: �X���[�g�a[m2]
% area: �@�̂̒f�ʐ�[m2]
% CLa: �g�͌X��[/rad]
% CD: �R�͌W��[-]
% length_GCM: �G���W���s�{�b�g�_����̏d�S�ʒu�x�N�g��[m](3x1)
% length_A: �G���W���s�{�b�g�_����̋�͒��S�_�ʒu�x�N�g��[m] (3x1)
% IXX,IYY,IZZ: �������[�����g[kgm2]
% IXXdot,IYYdot,IZZdot: �������[�����g�̎��ԕω�[kgm2/sec]
% azimth, elevation: �����p���̕��ʊp�A�p[deg]
m0 = 4.0;
Isp = 200;
g0 = 9.8;
FT = 150;
Tend = 4;
At = 0.01;
area = 0.010;
CLa = 3.5;
length_GCM = [-0.70; 0; 0]; length_A = [-0.50; 0; 0];
IXX = 5; IYY = 5; IZZ = 1;
IXXdot = 0; IYYdot = 0; IZZdot = 0;
azimth = 45; elevation = 80;

% ---- ������������Ɏg����ԗʂ̏����� ----
% pos0: �˓_���S�������W�n�ɂ�����ʒu�iUp-East-North)[m] (3x1)
% vel0: �˓_���S�������W�n�ɂ����鑬�x[m/s] (3x1)
% quat0: �@�̍��W�n���琅�����W�n�ɕϊ���\���N�H�[�^�j�I��[-] (4x1)
% omega0: �@�̍��W�n�ɂ�����@�̂ɓ����p���x[rad/s] (3x1)
pos0 = [0.0; 0.0; 0.0]; % m
vel0 = [0.0; 0.0; 0.0]; % m/s
quat0 = attitude(azimth, elevation);
omega0 = [0.0; 0.0; 0.0]; % rad/s
x0 = [m0; pos0; vel0; quat0; omega0];