#include "mex.hpp"
#include "mexAdapter.hpp"

#include <string>

#include <vector>
#include <memory>

#include <system_error>
#include <filesystem>

#include "ffilesystem.h"



class MexFunction : public matlab::mex::Function {
public:
  void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) {
// boilerplate engine & ArrayFactory setup
    std::shared_ptr<matlab::engine::MATLABEngine> matlabEng = getEngine();

    matlab::data::ArrayFactory factory;
// wrangle inputs
    std::string base, other;

    if (inputs.size() != 2) {
      matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: Two inputs required") }));
    }

    if ((inputs[0].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[0].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[0];
        base = stringArr[0];
    } else if (inputs[0].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[0];
        base.assign(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: First input must be a scalar string or char vector") }));
    }

     if ((inputs[1].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[1].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[1];
        other = stringArr[0];
    } else if (inputs[1].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[1];
        other.assign(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: Second input must be a scalar string or char vector") }));
    }

// actual function algorithm / computation
    std::error_code ec;
    std::string out;

    out = std::filesystem::proximate(other, base, ec).generic_string();

    if(ec)
      matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar(ec.message()) }));

    outputs[0] = factory.createScalar(out);
  }
};
