import 'package:flutter/widgets.dart';
import 'RegExp.dart';

class FormsValidation {
  void saveFormData(
      {FormState formState, String phone, String error, Function sendData}) {
    if (formState.validate() && phoneValidate(phone) == null) {
      formState.save();
      sendData();
    }
  }

  String phoneValidate(String fieldVal) {
    if (fieldVal.isEmpty) {
      return 'You should write your number';
    } else if (!phoneRegExp.hasMatch(fieldVal)) {
      return 'Invalid Phone number';
    } else {
      return null;
    }
  }

  // String nameValidate(String fieldVal) {
  //   if (fieldVal.length < 3) {
  //     return 'This is not a name';
  //   } else if (!usernameRegExp.hasMatch(fieldVal)) {
  //     return 'Username is not valid';
  //   } else {
  //     return null;
  //   }
  // }
}
