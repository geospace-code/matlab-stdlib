function a = file_attributes(p)
arguments
  p (1,1) string
end
% need arguments and stdlib.strempty for Matlab < R2020b

a = struct.empty;

if stdlib.strempty(p)
  return
end

[status, s] = fileattrib(p);

if status ~= 1
  return
end

a = s;
for n = ["GroupRead", "GroupWrite", "GroupExecute", "OtherRead", "OtherWrite", "OtherExecute"]

  if ~isfield(a, n) || isnan(a.(n))
    a.(n) = false;
  end

end

end
