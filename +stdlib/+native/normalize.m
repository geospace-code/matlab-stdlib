function n = normalize(p)

n = stdlib.posix(string(p));

uncslash = ispc() && startsWith(n, "//");

% use split to remove /../ and /./ and duplicated /
parts = split(n, '/');
i0 = 1;
if strncmp(n, "/", 1)
  n = "/";
elseif ispc() && strlength(n) >= 2 && ~stdlib.strempty(stdlib.root_name(p))
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
        n = n{1}(1:j(end)-1);
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

n = fullfile(n);

if stdlib.strempty(n)
  n = ".";
end

end
