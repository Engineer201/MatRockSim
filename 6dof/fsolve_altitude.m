% ===== RocketSim =====
% 6���R�x�̉^�����s�����đ̂̔��ăV�~�����[�^
% Matlab2014R��Octave3.6.4�œ�����m�F�B
% 
% Copyright (C) 2014, Takahiro Inagawa
% This program is free software under MIT license.
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
% ======================
function f = fsolve_altitude( burn_time )

addpath ../quaternion
addpath ../environment
addpath ../aerodynamics
addpath ../mapping
addpath ../gpssim
addpath ..

global ROCKET

% ---- �p�����[�^�ݒ�ǂݍ��� ----
% params_ROCKETinit_6dof
% params_test
% params_6dof
% params_M3S

% ---- �d�ʌv�Z ----
ROCKET.Tend = burn_time;
ROCKET.m0 = ROCKET.mf + ROCKET.FT * ROCKET.Tend / ROCKET.Isp / ROCKET.g0;


% ---- �p�����[�^�ݒ�ǂݍ��� ----
params_6dof

% ---- ����������� ----
AbsTol = [1e-4; % m
          1e-4; 1e-4; 1e-4; % pos
          1e-4; 1e-4; 1e-4; % vel
          1e-4; 1e-4; 1e-4; 1e-4; %quat
          1e-2; 1e-2; 1e-2]; % omega
options = odeset('Events', @events_land, 'RelTol', 1e-3, 'AbsTol', AbsTol);

time_end = 400;
% if time_parachute > time_end
%   time_parachute = time_end - 0.1;
% end

disp('====Start Simulation...====');

% �p���V���[�g�̗L���ŃV�~�����[�V�����̏ꍇ����
% if para_exist == true
%   tic
%   [T_rocket, X_rocket] = ode23s(@rocket_dynamics, [0 time_parachute], x0, options);
%   toc;tic
%   [T_parachute, X_parachute] = ode23s(@parachute_dynamics, [time_parachute time_end], X_rocket(length(X_rocket),:), options);
%   toc
%   T = [T_rocket; T_parachute];
%   X = [X_rocket; X_parachute];
% else
  % �p���{���b�N�t���C�g
  tic
  [T, X] = ode23s(@rocket_dynamics_6dof, [0 time_end], x0, options);
  toc
% end

max_altitude = max(X(:,2)) / 1000; % altitude
disp(['burn time: ', num2str(burn_time),' / Max Altitude: ', num2str(max_altitude)])
f = max_altitude - 100;