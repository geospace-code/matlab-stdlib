#include "mex.hpp"
#include "mexAdapter.hpp"

#include <vector>
#include <memory>

#if defined(_WIN32)
#define WIN32_LEAN_AND_MEAN
#include <windows.h>  // GetTokenInformation
#else
#include <unistd.h>  // geteuid
#include <sys/types.h>  // geteuid, pid_t
#endif


static bool fs_is_admin(){
  // running as admin / root / superuser
#if defined(_WIN32)
  HANDLE hToken = nullptr;
  TOKEN_ELEVATION elevation;
  DWORD dwSize;

  const bool ok = (OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &hToken) &&
     GetTokenInformation(hToken, TokenElevation, &elevation, sizeof(elevation), &dwSize));

  if(hToken)
    CloseHandle(hToken);
  if(ok)
    return elevation.TokenIsElevated;

  return false;
#else
  return geteuid() == 0;
#endif
}


class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabEng = getEngine();
    matlab::data::ArrayFactory factory;

    if (inputs.size() != 0) {
      matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: No input required") }));
    }

// actual function algorithm / computation
    bool y = fs_is_admin();

    outputs[0] = factory.createScalar<bool>(y);
  }
};
