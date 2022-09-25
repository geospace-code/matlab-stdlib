function h5_new_file(filename, varname, A, sizeA)

if isempty(sizeA)
  if isscalar(A)
    h5_write_scalar(filename, varname, A)
    return
  elseif isvector(A)
    h5create(filename, varname, length(A), "Datatype", class(A))
  else
    create_compress(filename, varname, A, size(A))
  end
else
  if isscalar(sizeA)
    if sizeA == 0
      h5_write_scalar(filename, varname, A)
      return
    else
      h5create(filename, varname, sizeA, "Datatype", class(A))
    end
  else
    create_compress(filename, varname, A, sizeA)
  end
end

h5write(filename, varname, A)

end % function
