function a = file_attributes(p)

[status, a] = fileAttribCompatible(p);

if status ~= 1
  a = struct([]);
  return
end

for n = ["GroupRead", "GroupWrite", "GroupExecute", "OtherRead", "OtherWrite", "OtherExecute"]

  if ~isfield(a, n) || isnan(a.(n))
    a.(n) = false;
  end

end

end
