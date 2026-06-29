url = 'https://github.com/matlab/terminal-in-matlab/releases/latest/download/Terminal.mltbx';
tbx = 'Terminal.mltbx';

websave(tbx, url);
matlab.addons.install(tbx)

disp('Terminal installed. start with   terminal()')
