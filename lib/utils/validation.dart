/// REGULAR EXPRESSION
class RegularExpression {
  /// TextField Enter Pattern Expression
   static String emailPattern = r"([a-zA-Z0-9_@gmail.com])";
  static String emailAddressValidationPattern = r"[a-zA-Z0-9$_@.-]";
  static String passwordPattern = r"[a-zA-Z0-9#!_@$%^&*-]";
  static String alphabetPattern = r"[a-zA-Z]";
  static String alphabetSpacePattern = r"[a-zA-Z ]";
  static String alphabetDigitSpacePattern = r"[a-zA-Z0-9#&$%_@.'?+ ]";
  static String alphabetDigitSpacePattern_ = r"[a-zA-Z0-9#&$%_@.'?+/ ]";
  static String alphabetDigitsPattern = r"[a-zA-Z0-9 ]";
  static String alphabetWithoutSpaceDigitsPattern = r"[a-zA-Z0-9]";
  static String alphabetDigitsSpacePlusPattern = r"[a-zA-Z0-9+ ]";
  static String alphabetDigitsSpecialSymbolPattern = r"[a-zA-Z0-9#&$%_@., ]";
  static String alphabetDigitsDashPattern = r"[a-zA-Z0-9- ]";
  static String addressValidationPattern = r'^\d+\s[A-Za-z\s]+';
  static String digitsPattern = "[0-9]";
  static String pricePattern = r'^\d+\.?\d*';
  static String leadingZero = r'^[1-9][0-9]*$';
  static String ifscCodePattern = r'^[A-Z]{4}0[A-Z0-9]{6}$';
  static String alphabetWithSpacePattern = r'^[A-Za-z]+[A-Za-z ]*$';
  static String pincodepattern = "[0-9]";
  // static String fullNamepattern = r'^[a-zA-Z]+ [a-zA-Z]+$';
  // static String fullNamepattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";

  static String spacePattern =  r"^(?!\s)";


  /// Validation Expression Pattern
  static String emailValidationPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String passwordValidPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static String linkValidationPattern =
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
}

/// ------------------------------------------------------------------- ///
/// VALIDATION MESSAGE WITH
class ValidationMsg {
  static String passisRequired = "Password is required";
  static String isRequired = 'Is required';
  static String phoneIsRequired = "Phone number is required";
  static String emailIsRequired = "Email is required";
  static String somethingWentToWrong = "Something went wrong";
  static String pleaseEnterValidEmail = "Please enter valid email";
  static String passwordLength = 'Must be more than 6 char';
  static String mobileNoLength = 'Phone number must be 10 digit';
  static String mobileNoLengthMoreThan10 =
      'Phone number cannot be more than 10 character';
  static String passwordInValid = 'Password invalid';
  static String invalidURl = 'Invalid URL';
  static String nameInvalid  = 'Invalid full name format. Use first name and last name.';
  static String fullname = 'Full name is required';
  static String addressisRequired = 'Address is required';
  static String addressInvalid = 'Invalid address format. Use street number and name.';
  static String addressLength = 'Address is too long (max 100 characters)';
  static String pincodelength = 'Pincode must be 6 Digit';
  // static String pincodeInvalid = 'Pincode cannot be more than 6 character';
  static String pincodeIsRequired = 'Pincode is required';
}

/// ------------------------------------------------------------------- ///
/// VALIDATION METHOD
class ValidationMethod {

  ///FULLNAME VALIDATION METHOD
  static String? validateFullName(value) {
    bool regex =
    RegExp(RegularExpression.alphabetPattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.fullname;
    } else if (regex == false) {
      return ValidationMsg.nameInvalid;
    }
    return null;
  }





  /// EMAIL VALIDATION METHOD
  static String? validateEmail(value) {
    bool regex =
    RegExp(RegularExpression.emailAddressValidationPattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.emailIsRequired;
    } else if (regex == false) {
      return ValidationMsg.pleaseEnterValidEmail;
    }
    return null;

  }

  /// PASSWORD VALIDATION METHOD
  static String? validatePassword(value) {
    RegExp regex = RegExp(RegularExpression.passwordPattern);
    if ((value as String).isEmpty) {
      return ValidationMsg.passisRequired;
    } else if (value.length <= 6) {
      return ValidationMsg.passwordLength;
    } else if (regex == false) {
      return ValidationMsg.passwordInValid;
    }

    return null;
  }


  // ///CONFIRM PASSWORD VALIDATION METHOD
  // static String? validateConfirmPassword(value) {
  //   RegExp regex = RegExp(RegularExpression.passwordValidPattern);
  //   if ((value as String).isEmpty) {
  //     return ValidationMsg.isRequired;
  //   } else if (value.length <= 6) {
  //     return ValidationMsg.passwordLength;
  //   } else if (regex == false) {
  //     return ValidationMsg.passwordInValid;
  //   }
  //
  //   return null;
  // }

  /// MOBILE VALIDATION METHOD
  static String? validatePhoneNo(value) {
    bool regex =
    RegExp(RegularExpression.digitsPattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.phoneIsRequired;
    } else if (regex == false) {
      return ValidationMsg.mobileNoLength;
    }
    return null;
  }

  ///PINCODE VALIDATION METHOD
  static  String? validateZipCode(value) {
    bool regex = RegExp(RegularExpression.pincodepattern).hasMatch(value);
    if ((value as String).isEmpty) {
      return ValidationMsg.pincodeIsRequired;
    }
    else if (regex == false) {
      return ValidationMsg.pincodelength;
    }

    return null;
  }

  ///ADDRESS VALIDATIONMETHOD
  static String? validateAddress( value) {
    RegExp regex2 = RegExp(RegularExpression.addressValidationPattern);
    if (value.isEmpty) {
      return ValidationMsg.addressisRequired;
    }
    else if (value.length > 100) {
      return ValidationMsg.addressLength;
    }
    else if (regex2 == false) {
      return ValidationMsg.addressInvalid;
    }
    return null;
  }



  /// IS REQUIRED VALIDATION METHOD  (COMMON METHOD)
  static String? validateIsRequired(value) {
    if ((value as String).isEmpty) {
      return ValidationMsg.isRequired;
    }
    return null;
  }
}
