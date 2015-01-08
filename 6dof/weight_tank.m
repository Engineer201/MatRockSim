function tank_weight = weight_tank( prop_weight, radius)
% �^���N�d�ʂ��v�Z����B
% @params prop_weight ���i�܏d��(kg)
% @params radius �^���N���a�i���a�j(m)
% @return tank_weight �^���N�d��(kg)
    % �p�����[�^
    of = 1.6; % O/F(-)
    rho_f = 789; % �R�����x(kg/m3)
    rho_o = 1140; % �_���ܖ��x(kg/m3)
    rho_Al = 2780; % �A���~���x(kg/m3)
    t_tank = 0.005; % �^���N����(m)
    
    % �v�Z
    % weight_ �d��(kg)
    weight_f = prop_weight * (1 / (of+1));
    weight_o = prop_weight * (of / (of+1));
    % V_ ���i�ܑ̐�(m3)
    V_f = weight_f / rho_f;
    V_o = weight_o / rho_o;
    % �^���N�̌`
    if 4/3*pi*radius^3 > V_f
        h_f = 0; % �^���N�̒�����(m)
    else
        h_f = V_f / pi / radius^2 - 4/3*radius;
    end
    if 4/3*pi*radius^3 > V_o
        h_o = 0; % �^���N�̒�����(m)
    else
        h_o = V_o / pi / radius^2 - 4/3*radius;
    end 
    % �^���N�̐�(m3)
    V_tank_f = 4/3*pi*((radius+t_tank)^3 - radius^3) + ...
               pi*h_f*(radius+t_tank)^2 - pi*h_f*radius^2;
    V_tank_o = 4/3*pi*((radius+t_tank)^3 - radius^3) + ...
               pi*h_o*(radius+t_tank)^2 - pi*h_o*radius^2;
    % �^���N�d��(kg)
    tank_weight = (V_tank_f + V_tank_o) * rho_Al;
end