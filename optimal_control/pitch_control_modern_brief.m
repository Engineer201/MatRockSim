clear all
% close all
% ----Constant----
% g: �d�͉����x(m/s2)
% mass: �d��(kg)
% force_t: ����(N)
% L_alpha: �g�͌X��(N/rad)
% length_A: ��͒��S�܂ł̋���(m)
% length_T: �W���o���_�܂ł̋���(m)
% theta0: �ڕW�p(������������̊p�x)(deg)
% vel_A: �@���������x(m/s)
% Iyy: �s�b�`�ʕ����̊������[�����g(kg*���Q)
% tau_delta: �W���o���p�ꎟ�x�ꎞ�萔(s)
% -----
% 
% ----------------
g = 9.8066;
mass = 70;
force_T = 1000;
L_alpha = 1000;
length_A = 0.2;
length_T = 1.5;
theta0 = 0;
vel_A = 30;
Iyy = 84;
% tau_delta = 0.5;
% ----
% Q_lqr = diag([0 100 0 0]);
% R_lqr = diag([0.00001]);
% W = 1;
% Q_kalman = diag([1 1 1 1]);
% R_kalman = diag([1 1 1 1]);

% ----��ԕ�����----
%�@sys: ��ԕ�����
% x = [z_dot; ��; ��_dot], u = delta_i, y = [z_dot_dot ��_dot]
% z_dot: �@�������������x
% ��: �ڕW�p�Ƃ̃Y��
% delta: �W���o���p
% delta_i: �W���o���p���͒l
% ---
% sys_servo: �g��n
% ----------------
A_reg = [-L_alpha/mass/vel_A g*cosd(theta0) -vel_A;
	 0 0 1;
	 L_alpha*length_A/Iyy/vel_A 0 0];
B_reg = [force_T/mass; 0; -force_T*length_T/Iyy];
C_reg = A_reg(1:2,:);
C_reg_observe = eye(length(C_reg));
D_reg = B_reg(1:2,:);
sys_reg = ss(A_reg, B_reg, C_reg, D_reg);
Co_reg = ctrb(A_reg, B_reg);

As_upper = horzcat(A_reg, [0; 0; 0]);
As_lower = [0 1 0 0];
A_servo  = [As_upper; As_lower];
B_servo = [B_reg; 0];
C_servo = horzcat(C_reg, [0; 0]);
C_servo_observe = eye(length(C_servo));
D_servo = D_reg;
sys_servo = ss(A_servo, B_servo, C_servo, D_servo);
sys_servo_observe = ss(A_servo, B_servo, C_servo_observe, [0]);

% ---- ���䐫�m�F ----
% ���䐫�ł͂Ȃ��A���萫�̋c�_���K�v
Co_servo = ctrb(sys_servo);
if length(A_servo) - rank(Co_servo) == 0
	disp('Controllable')
else
	disp('Uncontrollable')
end
% ---- �ϑ����m�F ----
Ob_servo = obsv(sys_servo);
if length(A_servo) - rank(Ob_servo) == 0
	disp('Observable')
else
	disp('Unobservable')
end


% % ---- �ɔz�u�@ ----
% J = [-1];
% K = place(A,B,J);
% sys_control = ss(A-B*K, eye(size(A)), eye(size(A)), eye(size(A)));

% % ----�œK���M�����[�^ ----
Q_optreg = [0 0 0 0;
	 0 1000 0 0;
	 0 0 0 0;
	 0 0 0 1];
R_optreg = [10000];
N_optreg = [0; 0; 0; 0];
[K_optreg, P_optreg, E_optreg] = lqr(sys_servo, Q_optreg, R_optreg, N_optreg);
sys_optreg = ss(A_servo-B_servo*K_optreg, B_servo, C_servo-D_servo*K_optreg, D_servo);


% ---- �œK�T�[�{�V�X�e�� ----
% Q11 = [100];
% Q22 = [500];
% Q_optservo = [ C_reg'*Q11*C_reg zeros(length(A_reg),1);
% 			   zeros(1, length(A_reg)) Q22];
% R_optservo = 1;
% P_optservo = care(A_servo, B_servo, Q_optservo, R_optservo);
% P_optservo11 = P_optservo(1:length(A_reg), 1:length(A_reg));
% P_optservo12 = P_optservo(1:length(A_reg), length(A_reg)+1);
% P_optservo22 = P_optservo(length(A_reg)+1, length(A_reg)+1);
% 
% K = -inv(R_optservo) * B_reg' * P_optservo11;
% G = -inv(R_optservo) * B_reg' * P_optservo12;
% 
% M0 = [A_reg B_reg;
% 	  C_reg 0];
% Fa = [-K+2*G*inv(P_optservo22)*P_optservo12' 1]...
% 		*inv(M0) * [zeros(length(A_reg),1); 1];
% Fb = -2*G*inv(P_optservo22)*P_optservo12';
% 
% y_ref = 0;
% x_0 = [0; 0.2; 0; 0];
% % �v���X����}�C�i�X�ɂ��Ă݂�
% K_optservo = [K G] + Fa * y_ref + Fb * x_0;
% sys_optservo = ss(A_servo - B_servo*K_optservo, eye(5), eye(5), eye(5));

%% ---- 2���R�x�ϕ��`�œK�T�[�{�V�X�e�� ----
%[F0 S Er] = lqr(sys_reg, Q_lqr, R_lqr);
%H0 = - inv(C_reg * inv(A_reg - B_reg * F0) * B_reg);
%F1 = C_reg * inv(A_reg - B_reg * F0);
%F2 = - R_lqr * B_reg' * F1';

% ---- �J���}���t�B���^ ----
% [L_kalman P E] = lqe(A_reg, [], C_reg_observe, Q_kalman, R_kalman);


% ---- 2���R�x�ϕ��`�œK�T�[�{�V�X�e�� ----
% ---- �ϕ�����������i�g��n�̑O�i�K�j�V�X�e����LQR���āA�ϕ��핪��W��������
% servo_2dof_A11 = A_reg - B_reg * F0 + B_reg * F1*F2*W;
% servo_2dof_A12 = B_reg * F2 * W;
% A_2dof = [servo_2dof_A11 servo_2dof_A12;
% 		  -C_reg 0];
% B_2dof = [B_reg*H0; 1];
% sys_2dofservo = ss(A_2dof, B_2dof, eye(5));
% eig(A_2dof)

% x_0 = [0; 0.2; 0; 0];
% t = 0:0.01:10;
% [y0,t,x0] = initial(sys_2dofservo, [x_0; 0], t);
% [y1,t,x1] = initial(sys_2dofservo, [x_0; 0], t);
% figure()
% subplot(3,1,1);plot(t,x0(:,1));
% grid;legend('z_dot');ylabel('m/s');
% subplot(3,1,2);plot(t,rad2deg(x0(:,2)));grid;
% legend('theta');ylabel('deg');
% subplot(3,1,3);plot(t,rad2deg(x0(:,3)));grid;
% legend('theta_dot');ylabel('deg/s');
% xlabel('time (sec)')

% figure()
% subplot(3,1,1);plot(t,rad2deg(x0(:,4)));grid;
% legend('delta');;ylabel('deg');
% subplot(3,1,2);plot(t,rad2deg(x0(:,5)));grid;
% legend('motor_dot');;ylabel('deg/s');
% subplot(3,1,3);plot(t,x0(:,6));grid;
% legend('current');;ylabel('A');
% xlabel('time (sec)')

% figure()
% subplot(3,1,1);plot(t,x0(:,5));grid;
% legend('theta_error');ylabel('deg');
% subplot(3,1,2);plot(t,x0(:,5));grid;
% legend('motor_error');ylabel('deg');
% xlabel('time (sec)')
% print ('Modern_state.jpg')


% ----�}��
x_0 = [0; 0.2; 0];
t = 0:0.01:10;
[y0,t,x0] = initial(sys_optreg, [x_0; 0], t);
% [y1,t,x1] = initial(sys_optservo, [x_0; 0], t);

figure()
subplot(3,1,1);plot(t,x0(:,1));
grid;legend('z_{dot}');ylabel('m/s');
subplot(3,1,2);plot(t,rad2deg(x0(:,2)));grid;
legend('theta');ylabel('deg');
subplot(3,1,3);plot(t,rad2deg(x0(:,3)));grid;
legend('theta_{dot}');ylabel('deg/s');
xlabel('time (sec)')

figure()
% subplot(2,1,1);plot(t,rad2deg(x0(:,4)));grid;
% legend('delta');;ylabel('deg');
subplot(2,1,2);plot(t,rad2deg(x0(:,4)));grid;
legend('theta_error');ylabel('deg*s');
xlabel('time (sec)')

%figure()
%subplot(4,1,1);plot(t,x1(:,1));
%grid;legend('z_{dot}');ylabel('m/s');
%subplot(4,1,2);plot(t,rad2deg(x1(:,2)));grid;
%legend('theta');ylabel('deg');
%subplot(4,1,3);plot(t,rad2deg(x1(:,3)));grid;
%legend('theta_{dot}');ylabel('deg/s');
%xlabel('time (sec)')
%subplot(4,1,4);plot(t,rad2deg(x1(:,4)));grid;
%legend('delta');;ylabel('deg');
%subplot(3,1,2);plot(t,rad2deg(x1(:,5)));grid;
%legend('theta_error');ylabel('deg*s');
%xlabel('time (sec)')

%figure()
%subplot(3,1,1);plot(t,x1(:,5));grid;
%legend('theta_error');ylabel('deg');
%subplot(3,1,2);plot(t,x1(:,5));grid;
%legend('motor_error');ylabel('deg');
%xlabel('time (sec)')
%print ('Modern_state.jpg')
