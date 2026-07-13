function [os, vers] = os_version()

os = char(java.lang.System.getProperty('os.name'));
vers = char(java.lang.System.getProperty('os.version'));

end
