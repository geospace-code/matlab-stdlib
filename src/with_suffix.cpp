#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>

#include <vector>
#include <memory>
#include <filesystem>

#include "ffilesystem.h"

class MexFunction : public matlab::mex::Function {
private:
#include "mex2string.inl"

public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {

    matlab::data::ArrayFactory factory;

    std::string path, suffix;

    matlab_2string(inputs, &path, &suffix);

    std::filesystem::path pth(path);

    std::string p = pth.replace_extension(suffix).string();

    if (p.empty()) {
      outputs[0] = factory.createArray<matlab::data::MATLABString>({0, 0});
    } else {
      outputs[0] = factory.createScalar(p);
    }
  }
};
