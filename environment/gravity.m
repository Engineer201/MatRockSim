function [gc, gnorth] = gravity( h, lat )
% GRAVITY �n�������]�����̉�]�ȉ~�̂Ɖ��肵�AJeffery�̑ы��W�����2���܂ōl������
% �d�͉����x�����߂�B
% ���S�͍͂l�����Ă��Ȃ��̂ŁA�n�ʌŒ�̏d�͉����x�Ɣ�r�����
% �����Ȓl���o�͂����B
% @param h ���x[m]
% @param lat �ܓx[rad]
% @return gc �n�����S�����d�͉����x[m/s2]
% @return gnorth �k�����d�͉����x[m/s2]
% �q��F���H�w�֗���P865�͖k�����̏d�͉����x���Ԉ���Ă���̂Œ��ӁB

mu = 3.986004e14;
Re = 6378.135e3;
J2 = 1.08263e-3;
epsilon = 1 / 298.257;
r = h + Re * (1 - epsilon * sin(lat) ^2);

gc = - mu / r^2 * (1 - 1.5 * J2 *(Re/r)^2 * (3*sin(lat)^2 - 1));
gnorth = mu / r^2 * J2 * (Re/r)^2 * sin(2*lat);