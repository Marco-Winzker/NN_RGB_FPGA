%==========================================================================
%
%   Author: Thomas Florkowski 
%   Version: 08.08.2020
%
%==========================================================================
%
% SIGMOID  Compute sigmoid function.
%   J = SIGMOID(z) computes the sigmoid of z.
%  

function g = sigmoid(z)
g = 1.0 ./ (1.0 + exp(-z));
end
