%% NORMALIZE remove redundant elements of path
% optional: mex
%
% normalize(p) remove redundant elements of path p
% path need not exist, normalized path is returned
%
%%% Inputs
% * p: path to normalize
%%% Outputs
% * c: normalized path
%
% MEX code is about 4-5x faster than plain Matlab below

function n = normalize(p)
arguments
  p (1,1) string
end

n = stdlib.posix(p);
if ~stdlib.len(n) && stdlib.is_url(p), return, end

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


%!testif 0
