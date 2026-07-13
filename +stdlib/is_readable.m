%% IS_READABLE is file readable
%
%%% Inputs
% * p: single path string
%%% Outputs
% * y: true if file is readable

function y = is_readable(p)
arguments
  p string {mustBeFileOrFolder}
end

if stdlib.matlabOlderThan('R2025a')
  a = file_attributes(p);
  y = a.UserRead || a.GroupRead || a.OtherRead;
else
  a = filePermissions(p);
  y = reshape([a.Readable], size(p));
end

end
