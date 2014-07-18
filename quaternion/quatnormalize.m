function qout = quatnormalize( q )
%  QUATNORMALIZE �N�H�[�^�j�I���̐��K��.
%
%   Examples:
%
%   Normalize q = [1 0 1 0]:
%      normal = quatnormalize([1 0 1 0])

qout = q./(quatnorm( q )* ones(1,4));
