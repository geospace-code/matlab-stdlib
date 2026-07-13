%% IS_WRITABLE is path writable
%
%%% Inputs
% * p: path to file or folder
%%% Outputs
% * y: true if file is writable

function y = is_writable(p)
arguments
  p string {mustBeFileOrFolder}
end

if stdlib.matlabOlderThan('R2025a')
  a = file_attributes(p);
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
else
  a = filePermissions(p);
  y = reshape([a.Writable], size(p));
end

end
