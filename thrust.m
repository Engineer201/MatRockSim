% ----
% ���͗���
% @param t: ���ݎ���[sec] (1x1)
% @param Tend: �R�ďI������[sec] (1x1)
% @param FT: ����[N] (1x1)
% @return ft: ����[N] (1x1)
% ----
function ft = thrust(t, Tends, FT)
	ft = 0.0;
	if t < Tends
		ft = FT;
	end
end
