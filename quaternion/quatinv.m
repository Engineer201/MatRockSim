% ----
% �ե��������˥���
% @param q: ���������˥��� (1x4)
% @param o: �ե��������˥��� (1x4)
% ----
function o = quatinv(p)
  o = quatconj(p) / (quatnorm(p)^2);
end
