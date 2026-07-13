function r = file_attributes(file)

[s, r] = fileattrib(file);

if ~s
  error('stdlib:file_attributes', 'Error executing fileattrib(%s): %s', file, r);
end

pv = {'GroupRead', 'GroupWrite', 'GroupExecute', 'OtherRead', 'OtherWrite', 'OtherExecute'};

for i = 1:numel(pv)
  n = pv{i};
  if ~isfield(r, n) || isnan(r.(n))
    r.(n) = false;
  end
end

end
