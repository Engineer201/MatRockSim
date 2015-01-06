function quat = target_angles ( t )
    % �@�̂̎p���X�P�W���[��
    % @param t: ���ݎ���[sec] (1x1)
    % @return quat: �p���̃N�H�[�^�j�I��[-] (1x4)
    % euler_maneuver�Ⴆ�΁A�A�W�}�X45�x�A�s�b�`80�x�̂Ƃ�[0, 10, 45](deg)
    % ====
    time_maneuver = [0, 2];
    euler_maneuver = [0 2 45; ...
                      0 2 45];
    euler_maneuver = deg2rad(euler_maneuver);
    for i = 1:length(time_maneuver)
        if t >= time_maneuver(i)
            euler = euler_maneuver(i,:);
        end
    end
    quat = euler2quat(euler);
end