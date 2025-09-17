%% PERL_VERSION get the Perl version used by MATLAB
% cached for speed
% to clear cache do "clear functions"
%
%%% Output
% * v: 1x3 vector of major, minor, micro version e.g. Perl 5.32.1 = [5, 32, 1]

function v = perl_version()

persistent perlv perlv_cached

if isempty(perlv_cached)
  perlv_cached = false;
elseif perlv_cached
  v = perlv;
  return
end

v = [];

exe = stdlib.perl_exe();

if ~stdlib.strempty(exe)
  cmd = sprintf('"%s" -e %s', exe, stdlib.perl.perl2cmd('print $^V'));

  [s, r] = system(cmd);

  if s == 0
    v = sscanf(r, 'v%d.%d.%d').';
  end
end

% cache the result - even if empty -- because the check takes up to 1000 ms say on HPC
perlv = v;
perlv_cached = true;

end

%!assert (~isempty(stdlib.perl_version()))