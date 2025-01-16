#include "mex.hpp"
#include "mexAdapter.hpp"

#include <vector>
#include <memory>


#if defined(__APPLE__) && defined(__MACH__)
#include <cerrno>
#include <sys/sysctl.h>
#endif

static bool fs_is_rosetta()
{
#if defined(__APPLE__) && defined(__MACH__)
// https://developer.apple.com/documentation/apple-silicon/about-the-rosetta-translation-environment
    int ret = 0;
    size_t size = sizeof(ret);

    if (sysctlbyname("sysctl.proc_translated", &ret, &size, nullptr, 0) < 0)
      return false;

    return ret == 1;
#else
    return false;
#endif
}


class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

    matlab::data::ArrayFactory factory;
// boilerplate input checks
    if (inputs.size() != 0) {
      matlabPtr->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("No input required") }));
    }

// actual function algorithm / computation
    bool y = fs_is_rosetta();

// convert to Matlab output
// https://www.mathworks.com/help/matlab/matlab_external/create-matlab-array-with-matlab-data-cpp-api.html
// https://www.mathworks.com/help/matlab/apiref/matlab.data.arrayfactory.html

    outputs[0] = factory.createScalar<bool>(y);
  }
};
