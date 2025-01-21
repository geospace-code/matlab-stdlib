void matlab_2string(matlab::mex::ArgumentList inputs, std::string* target, std::string* link)
  {
    std::shared_ptr<matlab::engine::MATLABEngine> matlabEng = getEngine();

    matlab::data::ArrayFactory factory;

    if (inputs.size() != 2) {
      matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: Two inputs required") }));
    }

    if ((inputs[0].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[0].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[0];
        *target = stringArr[0];
    } else if (inputs[0].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[0];
        *target = std::string(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: First input must be a scalar string or char vector") }));
    }

     if ((inputs[1].getType() == matlab::data::ArrayType::MATLAB_STRING && inputs[1].getNumberOfElements() == 1)){
        matlab::data::TypedArray<matlab::data::MATLABString> stringArr = inputs[1];
        *link = stringArr[0];
    } else if (inputs[1].getType() == matlab::data::ArrayType::CHAR){
        matlab::data::CharArray charArr = inputs[1];
        *link= std::string(charArr.begin(), charArr.end());
    } else {
        matlabEng->feval(u"error", 0,
        std::vector<matlab::data::Array>({ factory.createScalar("Mex: Second input must be a scalar string or char vector") }));
    }
  }
