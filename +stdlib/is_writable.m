%% IS_WRITABLE is path writable
%
%%% Inputs
% * file: path to file or folder
%%% Outputs
% * y: true if file is writable

function y = is_writable(file)
arguments
  file {mustBeTextScalar,mustBeFileOrFolder}
end

if stdlib.matlabOlderThan('R2025a')
  a = file_attributes(file);
  y = a.UserWrite || a.GroupWrite || a.OtherWrite;
else
  a = filePermissions(file);
  y = a.Writable;
end

end
