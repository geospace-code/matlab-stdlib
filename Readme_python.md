# Matlab to Python external language interface

[Python](https://www.mathworks.com/help/matlab/call-python-libraries.html)
on Matlab requires Matlab R2022b and newer.
`stdlib.has_python` checks that the Python version set by `pyenv()` is compatible with the Matlab release.
If there is a problem with Python on a particular Matlab install, `stdlib.has_python(false)` disables the Python backend for that Matlab session.

As with
[Java](./Readme_java.md),
with Prism emulation on Windows, the Python.exe must match the emulated CPU architecture.
For example, if the CPU is ARM64 but Matlab is x86_64, then download the
[standalone](https://www.python.org/downloads/windows/)
Python 64-bit (non-ARM64) installer and extract.
Then use `pyenv(Version='/path/to/python.exe')` to set the Python x86_64 version for Matlab x86_64 under Prism emulation.
