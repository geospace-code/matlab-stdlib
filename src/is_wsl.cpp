#include "mex.hpp"
#include "mexAdapter.hpp"

#include <vector>
#include <memory>

#include "linux_fs.h"


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
    int wsl = fs_is_wsl();

    outputs[0] = factory.createScalar<int>(wsl);
  }
};
