function a = file_attributes(p)
arguments
  p (1,1) string
end
% need arguments and stdlib.strempty for Matlab < R2020b

assert(~stdlib.strempty(p), 'Path must not be empty.');

[status, s] = fileattrib(p);

assert(status == 1, "'%s' is not a file or directory.", p);

a = s;
for n = ["GroupRead", "GroupWrite", "GroupExecute", "OtherRead", "OtherWrite", "OtherExecute"]

  if ~isfield(a, n) || isnan(a.(n))
    a.(n) = false;
  end

end

end
