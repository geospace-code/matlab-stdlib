%% IS_WRITABLE is path writable

function ok = is_writable(p)
arguments
  p {mustBeTextScalar}
end

try
  a = filePermissions(p);
  ok = a.Writable || (isa(a, "matlab.io.UnixPermissions") && (a.GroupWrite || a.OtherWrite));
catch e
  switch e.identifier
    case {'Octave:undefined-function', 'MATLAB:UndefinedFunction'}
      a = file_attributes_legacy(p);
      ok = ~isempty(a) && (a.UserWrite || a.GroupWrite || a.OtherWrite);
    otherwise, rethrow(e)
  end
end

end
%!assert (is_writable('is_writable.m'))
