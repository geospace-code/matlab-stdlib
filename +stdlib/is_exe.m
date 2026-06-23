%% IS_EXE is file executable
% does not check if the file is actually a binary executable
%
%%% inputs
% * file: path to check
%%% Outputs
% * y: true if path is a file and has executable permissions

function y = is_exe(file)
arguments
  file {mustBeTextScalar}
end

y = false;

if ispc() && ~has_windows_executable_suffix(file)
  return
end
if ~stdlib.exists(file)
  return
end

if stdlib.matlabOlderThan('R2025a')
  a = file_attributes(file);
  y = ~a.directory && (a.UserExecute || a.GroupExecute || a.OtherExecute);
else
  a = filePermissions(file);
  if a.Type == matlab.io.FileSystemEntryType.File
    if ispc
      y = a.Readable;
    else
      y = a.UserExecute || a.GroupExecute || a.OtherExecute;
    end
  end

end

end
