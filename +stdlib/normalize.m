%% NORMALIZE remove redundant elements of path
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path
% https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/nio/file/Path.html#normalize()

function n = normalize(p, use_java)
% arguments
%   p (1,1) string
%   use_java (1,1) logical = false
% end
if nargin < 2, use_java = false; end

if stdlib.isoctave()
  n = stdlib.posix(javaObject("java.io.File", p).toPath().normalize().toString());
elseif use_java
  n = stdlib.posix(java.io.File(p).toPath().normalize().toString());
else

  n = stdlib.posix(string(p));

  % use split to remove /../ and /./ and duplicated /
  parts = split(n, '/');
  i0 = 1;
  if startsWith(n, "/")
    n = "/";
  elseif ispc && strlength(n) >= 2 && strlength(stdlib.root_name(p))
    n = parts(1);
    i0 = 2;
  else
    n = "";
  end

  for i = i0:length(parts)
    if parts(i) == ".."
      if n == ""
        n = parts(i);
      elseif endsWith(n, "..")
        n = n + "/" + parts(i);
      else
        j = strfind(n, "/");
        if isempty(j)
          n = "";
        else
          n = extractBefore(n, j(end));
        end
      end
    elseif all(parts(i) ~= [".", ""])
      if n == ""
        n = parts(i);
      elseif n == "/"
        n = n + parts(i);
      else
        n = n + "/" + parts(i);
      end
    end
  end

end


if ~stdlib.len(n)
  n = ".";
end

end


%!assert(normalize("."), ".")
%!assert(normalize("./"), ".")
%!assert(normalize("a/.."), ".")
%!assert(normalize("a/../b"), "b")
%!assert(normalize("a/./b"), "a/b")
%!assert(normalize("a/./b/.."), "a")
%!assert(normalize(""), ".")
