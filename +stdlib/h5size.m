%% H5SIZE get shape of HDF5 variable
%
%%% Inputs
% filename: data filename
% variable: name of variable inside file
%%% Outputs
% fsize: vector of variable size per dimension. Empty if scalar variable.

function fsize = h5size(file, variable)
arguments
  file (1,1) string {mustBeFile}
  variable (1,1) string {mustBeNonzeroLengthText}
end

dsi = h5info(file, variable).Dataspace;

if ~stdlib.isoctave() && dsi.Type == "scalar"
  fsize = [];
else
  fsize = dsi.Size;
end

end


%!test
%! pkg load hdf5oct
%! fn = tempname();
%! ds = '/a';
%! a = [1,2];
%! h5save_new(fn, ds, a, size(a), 0)
%! assert(h5size(fn, ds), uint64([1,2]))
%! delete(fn)
