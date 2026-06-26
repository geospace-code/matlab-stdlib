%% CMDSEP shell command separator
%
% char used to separate commands in a shell command string.
%
% Ref: https://www.mathworks.com/help/matlab/ref/cmdsep.html

function s = cmdsep()

if stdlib.matlabOlderThan("R2023b")
  s = '&&';
else
  s = cmdsep();
end

end
