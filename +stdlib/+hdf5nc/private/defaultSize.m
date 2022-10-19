function s = defaultSize(A)
if isscalar(A)
  s = 0;
elseif isvector(A)
  s = length(A);
else
  s = size(A);
end

end
