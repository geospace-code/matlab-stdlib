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


try
  a = filePermissions(file);
  if a.Type == matlab.io.FileSystemEntryType.File
    if ispc
      y = a.Readable;
    else
      y = a.UserExecute || a.GroupExecute || a.OtherExecute;
    end
  end
catch e
  switch e.identifier
    case 'MATLAB:io:filesystem:filePermissions:CannotFindLocation'
      y = false;
    case {'MATLAB:UndefinedFunction', 'Octave:undefined-function'}
      a = file_attributes(file);
      y = ~isempty(a) && ~a.directory && (a.UserExecute || a.GroupExecute || a.OtherExecute);
    otherwise
      rethrow(e)
  end
end

end

%!test
%! if isunix()
%! assert(stdlib.is_exe([matlabroot, '/bin/octave']))
%! end
%!assert (~stdlib.is_exe('.'))
