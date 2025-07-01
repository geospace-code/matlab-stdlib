%% GET_MODTIME get path modification time
% requires: java
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * t: modification time, or empty if path does not exist

function t = get_modtime(p)
arguments
  p {mustBeTextScalar}
end


if stdlib.isoctave()
  [s, err] = stat(p);
  if err == 0
    t = s.mtime;
  else
    t = [];
  end
  return
end

t = javaFileObject(p).lastModified() / 1000;

if t > 0
  t = datetime(t, ConvertFrom="PosixTime");
else
  t = datetime.empty;
end

end

%!test
%! p = tempname();
%! assert(touch(p, now))
%! assert(get_modtime(p) > 0)
%! delete(p)
