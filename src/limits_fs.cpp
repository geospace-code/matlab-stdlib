#include <cstdlib>

#if defined(__APPLE__) && defined(__MACH__)
#include <sys/syslimits.h>
#endif

#if __has_include(<limits.h>)
#include <limits.h>
#endif

#include "limits_fs.h"


std::size_t fs_get_max_path()
{
#if defined(PATH_MAX)
  return PATH_MAX;
#elif defined(_WIN32)
  return _MAX_PATH;
#else
  return 1024;
#endif
}
