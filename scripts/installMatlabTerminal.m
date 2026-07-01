url = 'https://github.com/matlab/terminal-in-matlab/releases/latest/download/Terminal.mltbx';
tbx = 'Terminal.mltbx';

websave(tbx, url);
installed = mpminstall(tbx);

disp(installed.Name + " " + installed.Summary + " installed. start with   terminal()")
