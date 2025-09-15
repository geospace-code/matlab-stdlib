%% IS_EXE is file executable
% does not check if the file is actually a binary executable
%
%%% inputs
% file: path to check
%%% Outputs
% ok: true if path is a file and has executable permissions
%
% this method is like 40x faster than native.

function y = is_exe(file)

y = false;

if ispc() && ~has_windows_executable_suffix(file)
  return
end

a = stdlib.legacy.file_attributes(file);

if ~isempty(a)
  y = ~a.directory && (a.UserExecute || a.GroupExecute || a.OtherExecute);
end

end
