%==========================================================================
%
%   Author: Thomas Florkowski
%   Version: 10.08.2020
%   Release: Marco Winzker, Hochschule Bonn-Rhein-Sieg, 17.09.2020
%
%==========================================================================

%   This script converts flaoting point parameters to fixed point
                             
fprintf('Starting Script\n')

load NN_RGB_2_Categories_config.mat %Load .mat file

factor=5;
upscale=8;

inputFactor = 1/((2^upscale)-1);

network1 = ((2^factor)) * nnParams{1};
network2 = ((2^factor)) * nnParams{2};

network1(:,4)=network1(:,4)*((2^upscale));
network2(:,4)=network2(:,4)*((2^upscale));

network1 = int32(network1);
network2 = int32(network2);

fprintf('\nFixed Point Matrix for Hidden Layer\n')
disp(network1);
fprintf('Fixed Point Matrix for Output Layer\n')
disp(network2);

fprintf('\nFinished Script\n')
