uuid = "stdlib";

cwd = fullfile(fileparts(mfilename('fullpath')), "..");

toolboxFolder = fullfile(cwd, "+stdlib");

disp(toolboxFolder)

opts = matlab.addons.toolbox.ToolboxOptions(toolboxFolder, uuid);
opts.OutputFile = fullfile(cwd, uuid + ".mltbx");

opts.ToolboxName = "stdlib for Matlab";

opts.SupportedPlatforms.Win64 = true;
opts.SupportedPlatforms.Mac = true;
opts.SupportedPlatforms.Glnxa64 = true;
opts.SupportedPlatforms.MatlabOnline = true;

opts.MinimumMatlabRelease = "R2017a";
opts.MaximumMatlabRelease = "";

matlab.addons.toolbox.packageToolbox(opts);