import 'dart:math';

import 'package:Hackathon/authentication/login/login_bloc/login_event.dart';
import 'package:Hackathon/authentication/login/login_bloc/login_provider.dart';
import 'package:flutter/foundation.dart';

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

/// <h1>login_repo</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:46 pm
/// 

class LoginRepo {
  LoginProvider loginProvider = LoginProvider();
  login({@required String userName, @required String password})async{
    return await loginProvider.login(userName: userName, password: password);
  }

  socialLogin({@required SocialLogin socialLogin})async{
    return await loginProvider.socialLogin(socialLogin: socialLogin);
  }
}