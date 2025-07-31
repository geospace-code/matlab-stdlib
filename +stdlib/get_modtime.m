%% GET_MODTIME get path modification time
%
%%% Inputs
% * p: path to examine
%%% Outputs
% * t: modification time, or empty if path does not exist

function t = get_modtime(p)
arguments
  p {mustBeTextScalar}
end

finf = dir(p);
if isfolder(p)
  % find which index of the struct array has member name == '.'
  i = find(strcmp({finf.name}, '.'), 1);
  finf = finf(i);
end

if isempty(finf)
  t = datetime.empty;
else
  t = datetime(finf.datenum, 'ConvertFrom', 'datenum');
end

end
