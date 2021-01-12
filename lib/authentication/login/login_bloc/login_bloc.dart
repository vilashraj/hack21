import 'package:Hackathon/authentication/login/login_bloc/login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

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

/// <h1>login_bloc</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:46 pm
/// 

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginRepo loginRepo = LoginRepo();
  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try{
      if(event is LoginButtonPressed){
        yield LoginLoading();
        await loginRepo.login(userName: event.userName, password: event.password);
        yield LoginSuccess();
      }
      else if(event is SocialButtonPressed){
        yield LoginLoading();
        await loginRepo.socialLogin(socialLogin: event.socialLogin);
        yield LoginSuccess();
      }
    }catch(e){
      yield LoginError(e.toString());
    }
  }
}