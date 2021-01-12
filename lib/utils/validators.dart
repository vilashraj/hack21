import 'package:Hackathon/constants/string_constants.dart';
import 'package:flutter/material.dart';

///
/// Meditab Software Inc. CONFIDENTIAL
/// __________________
/// 
///  [2018] Meditab Software Inc.
///  All Rights Reserved.
/// 
/// NOTICE:  All information contained herein is, and remains
/// the property of Meditab Software Inc. and its suppliers,
/// if any.  The intellectual and technical concepts contained
/// herein are proprietary to Meditab Software Incorporated
/// and its suppliers and may be covered by U.S. and Foreign Patents,
/// patents in process, and are protected by trade secret or copyright law.
/// Dissemination of this information or reproduction of this material
/// is strictly forbidden unless prior written permission is obtained
/// from Meditab Software Incorporated.

/// <h1>validators</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 3:06 pm
/// 

class Validators {
  static String emailValidation(String value) {
    bool emailValid = RegExp(StringConstants.emailRegExp).hasMatch(value);
    if (value.isEmpty)
      return StringConstants.pleaseEnterEmail;
    else if (!emailValid)
      return StringConstants.pleaseEnterValidEmail;
    else
      return null;
  }

  static String passwordValidation(String value) {
    if (value.isEmpty)
      return StringConstants.pleaseEnterPassword;
    else if (value.length < 8)
      return StringConstants.passwordAtLeast8Char;
    else if (value.length > 128)
      return StringConstants.passwordAtMost128Char;
    else
      return null;
  }
  static String confirmPasswordValidation(String value, TextEditingController controller) {
    if (value.isEmpty)
      return StringConstants.pleaseEnterPassword;
    else if (value != controller.value.text)
      return StringConstants.passwordDoesNotMatch;
    else
      return null;
  }

}