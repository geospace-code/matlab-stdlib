function a = file_attributes_legacy(p)
arguments
  p {mustBeTextScalar}
end

assert(~strempty(p), 'Path must not be empty.')

[status, s] = fileattrib(p);

assert(status == 1, "'%s' is not a file or directory.", p);

a = s;
for n = {"GroupRead", "GroupWrite", "GroupExecute", "OtherRead", "OtherWrite", "OtherExecute"}
  name = n{1};

  if ~isfield(a, name) || isnan(a.(name))
    a.(name) = false;
  end
end
end
