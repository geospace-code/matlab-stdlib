%% IS_URL is true if the string is a URL.
% e.g. https://example.invalid is true

function y = is_url(s)
arguments
  s {mustBeTextScalar}
end

y = startsWith(s, alphanumericsPattern + "://");

end

%!testif 0
