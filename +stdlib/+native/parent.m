function p = parent(pth)

f = fullfile(char(pth));
if endsWith(f, {'/', filesep}) && ~strcmp(f, stdlib.root(f))
  f = f(1:end-1);
end

p = fileparts(f);

if stdlib.strempty(p)
  p = '.';
elseif ispc() && strcmp(p, stdlib.root_name(pth))
  p = strcat(p, filesep);
end

p = string(p);

end
