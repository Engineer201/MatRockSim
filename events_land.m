% ----
% matlab ode�̃C�x���g
% options = odeset('Events', @events_land);
% �̂悤�Ɏg�p�BMathWorks�̗���Q�Ƃ̂��ƁB
% @param t: ode�̒��̎����i���܂��Ȃ��j
% @param x: ode�̒��̏�ԁi���܂��Ȃ��j
% @return value: �C�x���g�������肷���ԗʁi�������W�n�̍��������j
% @return isterminal: value=0�̂Ƃ��ɃV�~�����[�V�������~(1)���邩�p�����邩(0)
% @return direction: ���߂�[�������̕���(-1:������̂�, 0:��������, 1:������̂�)
% ----
function [value,isterminal,direction] = events_land(t,x)
	value = x(2);
	isterminal = 1;
	direction = -1;
end