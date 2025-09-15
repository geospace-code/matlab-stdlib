function a = file_attributes(p)

a = struct.empty;

% need stdlib.strempty for Matlab < R2020b
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
