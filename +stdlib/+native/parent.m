function p = parent(pth)
arguments
  pth string
end

f = fullfile(pth);

i = endsWith(f, ["/", filesep]) & ~strcmp(f, stdlib.root(f));

f(i) = extractBefore(f(i), strlength(f(i)));

p = fileparts(f);

i = stdlib.strempty(p);
p(i) = ".";

% the ~all(i) is for Windows Matlab < R2025a
if ispc() && ~all(i)
  i = p(~i) == stdlib.root_name(pth(~i));
  p(i) = strcat(p(i), filesep);
end

end
