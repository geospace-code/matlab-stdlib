function a = file_attributes(p)

assert(strlength(p), 'Path must not be empty.')

[status, s] = fileattrib(p);

assert(status == 1, "'%s' is not a file or directory.", p);

a = s;
for n = ["GroupRead", "GroupWrite", "GroupExecute", "OtherRead", "OtherWrite", "OtherExecute"]

  if ~isfield(a, n) || isnan(a.(n))
    a.(n) = false;
  end

end

end
