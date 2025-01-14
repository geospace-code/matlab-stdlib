function a = file_attributes(p)
arguments
  p (1,1) string
end

a = [];

if stdlib.len(p) == 0
  return
end

[status, a] = fileattrib(p);
if status ~= 1
  % matlab puts the error message in the struct
  a = [];
  return
end

for n = {"GroupRead", "GroupWrite", "GroupExecute", "OtherRead", "OtherWrite", "OtherExecute"}
  name = n{1};
  if ~isfield(a, name) || isnan(a.(name))
    a.(name) = false;
  end
end

end
