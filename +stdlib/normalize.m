%% NORMALIZE remove redundant elements of path
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path

function n = normalize(p)
arguments
  p (1,1) string
end

n = stdlib.posix(p);

uncslash = ispc && startsWith(n, "//");

% use split to remove /../ and /./ and duplicated /
parts = split(n, '/');
i0 = 1;
if strncmp(n, "/", 1)
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

if uncslash
  n = strcat("/", n);
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
