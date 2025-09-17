function a = file_attributes(p)

[status, a] = fileAttribCompatible(p);

if status ~= 1
  a = struct([]);
  return
end

pv = {'GroupRead', 'GroupWrite', 'GroupExecute', 'OtherRead', 'OtherWrite', 'OtherExecute'};

for i = 1:numel(pv)
  n = pv{i};
  if ~isfield(a, n) || isnan(a.(n))
    a.(n) = false;
  end
end

end
