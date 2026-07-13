%% HAS_PERL checks if Perl is available in the current environment.

function y = has_perl()

v = stdlib.perl_version();
y = ~isempty(v) && ~any(ismissing(v));

end
