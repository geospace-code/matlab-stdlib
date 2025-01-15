#include <string>
#include <cstddef>

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <winioctl.h>

#include "win32_fs.h"


// create type PREPARSE_DATA_BUFFER
// from ntifs.h, which can only be used by drivers
// typedef is copied from https://gitlab.kitware.com/utils/kwsys/-/blob/master/SystemTools.cxx
// that has a BSD 3-clause license
typedef struct _REPARSE_DATA_BUFFER
{
  ULONG ReparseTag;
  USHORT ReparseDataLength;
  USHORT Reserved;
  union
  {
    struct
    {
      USHORT SubstituteNameOffset;
      USHORT SubstituteNameLength;
      USHORT PrintNameOffset;
      USHORT PrintNameLength;
      ULONG Flags;
      WCHAR PathBuffer[1];
    } SymbolicLinkReparseBuffer;
    struct
    {
      USHORT SubstituteNameOffset;
      USHORT SubstituteNameLength;
      USHORT PrintNameOffset;
      USHORT PrintNameLength;
      WCHAR PathBuffer[1];
    } MountPointReparseBuffer;
    struct
    {
      UCHAR DataBuffer[1];
    } GenericReparseBuffer;
    struct
    {
      ULONG Version;
      WCHAR StringList[1];
      // In version 3, there are 4 NUL-terminated strings:
      // * Package ID
      // * Entry Point
      // * Executable Path
      // * Application Type
    } AppExecLinkReparseBuffer;
  } DUMMYUNIONNAME;
} REPARSE_DATA_BUFFER, *PREPARSE_DATA_BUFFER;


static bool fs_win32_get_reparse_buffer(std::string path, std::byte* buffer)
{
// this function is adapted from
// https://gitlab.kitware.com/utils/kwsys/-/blob/master/SystemTools.cxx
// that has a BSD 3-clause license

  const DWORD attr = GetFileAttributesA(path.data());
// https://learn.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-getfileattributesa

// https://learn.microsoft.com/en-us/windows/win32/fileio/file-attribute-constants
  if (attr == INVALID_FILE_ATTRIBUTES || !(attr & FILE_ATTRIBUTE_REPARSE_POINT))
    return false;

  // Using 0 instead of GENERIC_READ as it allows reading of file attributes
  // even if we do not have permission to read the file itself

  // A reparse point may be an execution alias (Windows Store app), which
  // is similar to a symlink but it cannot be opened as a regular file.
  // We must look at the reparse point data explicitly.

  // FILE_ATTRIBUTE_REPARSE_POINT means:
  // * a file or directory that has an associated reparse point, or
  // * a file that is a symbolic link.
  HANDLE h = CreateFileA(
    path.data(), 0, 0, nullptr, OPEN_EXISTING,
    FILE_FLAG_OPEN_REPARSE_POINT | FILE_FLAG_BACKUP_SEMANTICS, nullptr);

  if (h == INVALID_HANDLE_VALUE)
    return false;

  DWORD bytesReturned = 0;

  BOOL ok = DeviceIoControl(h, FSCTL_GET_REPARSE_POINT, nullptr, 0, buffer,
                        MAXIMUM_REPARSE_DATA_BUFFER_SIZE, &bytesReturned,
                        nullptr);

  CloseHandle(h);

  return ok;
}


bool fs_win32_is_symlink(std::string path)
{
// distinguish between Windows symbolic links and reparse points as
// reparse points can be unlike symlinks.
//
// this function is adapted from
// https://gitlab.kitware.com/utils/kwsys/-/blob/master/SystemTools.cxx
// that has a BSD 3-clause license

  std::byte buffer[MAXIMUM_REPARSE_DATA_BUFFER_SIZE];
  // Since FILE_ATTRIBUTE_REPARSE_POINT is set this file must be
  // a symbolic link if it is not a reparse point.
  if (!fs_win32_get_reparse_buffer(path, buffer))
    return GetLastError() == ERROR_NOT_A_REPARSE_POINT;

  ULONG reparseTag =
    reinterpret_cast<PREPARSE_DATA_BUFFER>(&buffer[0])->ReparseTag;

  return (reparseTag == IO_REPARSE_TAG_SYMLINK) ||
         (reparseTag == IO_REPARSE_TAG_MOUNT_POINT);

}
