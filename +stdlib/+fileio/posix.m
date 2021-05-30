function ppath = posix(varargin)
% convert a path or sequence of path components to a Posix path separated
% with "/" even on Windows.
% If Windows path also have escaping "\" this breaks--this is fixable by
% regex so let us know if this becomes an issue.

ppath = fullfile(varargin{:});

if ispc
  ppath = strrep(ppath, "\", "/");
end

end % function
