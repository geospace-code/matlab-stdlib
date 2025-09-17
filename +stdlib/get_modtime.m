%% GET_MODTIME get path modification time
%
%%% Inputs
% * file: path to examine
%%% Outputs
% * t: modification time, or empty if path does not exist
%
% Matlab < R2018a needs char input

function t = get_modtime(file)

finf = dir(file);

if ~isempty(finf) && finf.isdir
  % find which index of the struct array has member name == '.'
  i = find(strcmp({finf.name}, '.'), 1);
  finf = finf(i);
end

if isempty(finf)
  t = datetime.empty;
else
  t = finf.datenum;
end

try %#ok<TRYNC>
  t = datetime(finf.datenum, 'ConvertFrom', 'datenum');
end

end

%!assert (stdlib.get_modtime('.') > 0)