function o = quatinv(p)
% QUATINV �t�N�H�[�^�j�I��
% 	@param q: �N�H�[�^�j�I�� (1x4)
% 	@param o: �t�N�H�[�^�j�I�� (1x4)
	o = quatconj(p) / (norm(p)^2);
end
