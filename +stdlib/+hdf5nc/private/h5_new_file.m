function h5_new_file(filename, varname, A, sizeA)

if isempty(sizeA)
  if isscalar(A)
    sizeA = 0;
  elseif isvector(A)
    sizeA = length(A);
  else
    sizeA = size(A);
  end
end

if isscalar(sizeA)
  if sizeA == 0
    if verLessThan('matlab', '9.8')
      h5create(filename, varname, 1, "Datatype", class(A))
    else
      h5_write_scalar(filename, varname, A)
      return
    end
  else
    h5create(filename, varname, sizeA, "Datatype", class(A))
  end
else
  create_compress(filename, varname, A, sizeA)
end

h5write(filename, varname, A)

end % function
