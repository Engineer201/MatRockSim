function [ ] = thrustmake( filename, thrust , endtime )
%THRUSTMAKE ��萄�͂̐��͗�����RASP�t�H�[�}�b�g���o�͂���B
% @param filename �o�͂���t�@�C����
% @param thrust ��萄��[N]
% @param endtime �R�ďI������[s]
[fid, msg] = fopen(filename, 'w');
fprintf(fid, 'hoge 0 0 hoge 0 0 hoge\n');

time = [0.1; endtime; endtime + 0.1];
thrustcurve = [thrust; thrust; 0];
for i = 1:length(time)
    fprintf(fid, '%f %f\n', time(i), thrustcurve(i));
end
fclose(fid);
end
