% ----
% �˓_���W�n����ECEF���W�n�֍��W�ϊ�
% @param u,e,n �˓_���S���W�n��Up-East-North���W[m] (nx1)x3
% @param xr,yr,zr ECEF���W��̎Q�ƈʒu�i�˓_�j:[m] (1x1)x3
% @return x,y,z ECEF���W�n��̍��W[m] (nx1)x3
% ----
function [x, y, z] = launch2ecef(u, e, n, xr, yr, zr)
% �˓_�̈ܓx�o�x
[phi, ramda, height] = ecef2blh(xr,yr,zr);
phi = deg2rad(phi);
ramda = deg2rad(ramda);
x = -sin(phi)*cos(ramda)*n - sin(ramda)*e - cos(phi)*cos(ramda)*(-u) + xr;
y = -sin(phi)*sin(ramda)*n + cos(ramda)*e - cos(phi)*sin(ramda)*(-u) + yr;
z = cos(phi)*n - sin(phi)*(-u) + zr;