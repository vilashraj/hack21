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

/// <h1>string_constants</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 3:07 pm
/// 

class StringConstants {
  static final emailRegExp = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static final pleaseEnterValidEmail = "Please enter valid email.";
  static final pleaseEnterEmail = "Please enter the email.";

  static final pleaseEnterPassword = "Please enter the password";
  static final passwordAtLeast8Char = "Password length at least 8 characters";
  static final passwordAtMost128Char = "Password length at most 128 characters";
  static final passwordDoesNotMatch = "Password does not match";
}