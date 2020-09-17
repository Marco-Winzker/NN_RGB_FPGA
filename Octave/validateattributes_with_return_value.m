%==========================================================================
%
%   Author: Thomas Florkowski 
%   Version: 08.08.2020
%
%==========================================================================
% Needed to fix a bug with octave
% https://stackoverflow.com/questions/57679778/problem-with-validateattributes-function-in-octave

function rv = validateattributes_with_return_value (varargin)
  try
    validateattributes (varargin{:});
    rv = true;
  catch
    rv = false;
  end
end