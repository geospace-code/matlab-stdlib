%% IS_EXE is file executable
%
% false if not a file

function ok = is_exe(p)
arguments
  p {mustBeTextScalar}
end

if ~isfile(p)
  ok = false;
  return
end

try
  a = filePermissions(p);
  ok = a.UserExecute || (isa(a, "matlab.io.UnixPermissions") && (a.GroupExecute || a.OtherExecute));
catch e
  switch e.identifier
    case {'Octave:undefined-function', 'MATLAB:UndefinedFunction'}
      a = file_attributes_legacy(p);
      ok = ~isempty(a) && (a.UserExecute || a.GroupExecute || a.OtherExecute);
    otherwise, rethrow(e)
  end
end

%!assert (!is_exe("."))
%!assert (is_exe(program_invocation_name))
