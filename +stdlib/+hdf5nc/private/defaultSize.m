function s = defaultSize(A)

if isvector(A)
  s = length(A);
else
  s = size(A);
end

end
