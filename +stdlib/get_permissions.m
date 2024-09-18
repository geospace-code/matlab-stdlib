function p = get_permissions(f)
arguments
  f (1,1) string
end

p = string.empty;

% Get the permissions of a file or directory
[status, v] = fileattrib(f);
if status == 0
  return
end

% Extract the permission string
p = "---------"; % Default permissions
if v.UserRead
  p = replaceBetween(p, 1, 1, "r");
end
if v.UserWrite
  p = replaceBetween(p, 2, 2, "w");
end
if v.UserExecute
  p = replaceBetween(p, 3, 3, "x");
end
if ~isnan(v.GroupRead) && logical(v.GroupRead)
  p = replaceBetween(p, 4, 4, "r");
end
if ~isnan(v.GroupWrite) && logical(v.GroupWrite)
  p = replaceBetween(p, 5, 5, "w");
end
if ~isnan(v.GroupExecute) && logical(v.GroupExecute)
  p = replaceBetween(p, 6, 6, "x");
end
if ~isnan(v.OtherRead) && logical(v.OtherRead)
  p = replaceBetween(p, 7, 7, "r");
end
if ~isnan(v.OtherWrite) && logical(v.OtherWrite)
  p = replaceBetween(p, 8, 8, "w");
end
if ~isnan(v.OtherExecute) && logical(v.OtherExecute)
  p = replaceBetween(p, 9, 9, "x");
end

end
