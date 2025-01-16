#include "mex.hpp"
#include "mexAdapter.hpp"

#include <vector>
#include <memory>

#include "admin_fs.h"


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
