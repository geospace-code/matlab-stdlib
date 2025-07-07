%% IS_READABLE is file readable

function ok = is_readable(p)
arguments
  p {mustBeTextScalar}
end

try
  a = filePermissions(p);
  ok = a.Readable || (isa(a, "matlab.io.UnixPermissions") && (a.GroupRead || a.OtherRead));
catch e
  switch e.identifier
    case {'Octave:undefined-function', 'MATLAB:UndefinedFunction'}
      a = file_attributes_legacy(p);
      ok = ~isempty(a) && (a.UserRead || a.GroupRead || a.OtherRead);
    otherwise, rethrow(e)
  end
end

%!assert (is_readable('is_readable.m'))
