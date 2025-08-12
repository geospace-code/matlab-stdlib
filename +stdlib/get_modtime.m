%% GET_MODTIME get path modification time
%
%%% Inputs
% * file: path to examine
%%% Outputs
% * t: modification time, or empty if path does not exist

function t = get_modtime(file)
arguments
  file
end

finf = dir(file);
if isfolder(file)
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
