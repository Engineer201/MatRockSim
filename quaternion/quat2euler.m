function angles = quat2euler( q )
% QUAT2EULER UEN���W�n�����3-2-1�̉�]�ł�yaw,pitch,roll�̃I�C���[�p
% @param q: UEN���W�n����@�̍��W�n�ւ̕ϊ��N�H�[�^�j�I�� (Nx4)
% @return angles: 3-2-1�̉�]�ł�yaw, pitch, roll�̃I�C���[�p(rad) (Nx3)
%
%   Examples:
%
%   Determine the Euler angles from q = [1 0 1 0]:
%      ea = quat2euler([1 0 1 0])
%
%   Determine the Euler angles from multiple quaternions:
%      q = [1 0 1 0; 1 0.5 0.3 0.1];
%      ea = quat2euler(q)

qin = quatnormalize( q );

yaw = atan2(2.*(qin(:,2).*qin(:,3) + qin(:,1).*qin(:,4)), ...
                 qin(:,1).^2 + qin(:,2).^2 - qin(:,3).^2 - qin(:,4).^2);

pitch = asin(-2.*(qin(:,2).*qin(:,4) - qin(:,1).*qin(:,3)));

roll = atan2(2.*(qin(:,3).*qin(:,4) + qin(:,1).*qin(:,2)), ...
                 qin(:,1).^2 - qin(:,2).^2 - qin(:,3).^2 + qin(:,4).^2);

angles = [yaw pitch roll];
