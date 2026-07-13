%% IS_READABLE is file readable
%
%%% Inputs
% * file: single path string
%%% Outputs
% * y: true if file is readable

function y = is_readable(file)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
end

if stdlib.matlabOlderThan('R2025a')
  a = file_attributes(file);
  y = a.UserRead || a.GroupRead || a.OtherRead;
else
  a = filePermissions(file);
  y = a.Readable;
end

end
