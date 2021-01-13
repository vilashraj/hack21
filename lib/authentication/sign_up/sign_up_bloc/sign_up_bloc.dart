
import 'package:Hackathon/authentication/sign_up/sign_up_bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_event.dart';
import 'sign_up_repo.dart';

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

/// <h1>sign_up_bloc</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 3:17 pm
/// 

class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpRepo signUpRepo = SignUpRepo();
  SignUpBloc(SignUpState initialState) : super(initialState);

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async*{
    try{
      if(event is SignUpButtonPressed){
        yield SignUpLoading();
        await signUpRepo.signUp(password: event.password, userName: event.userName);
        yield SignUpSuccess();
      }
      else if(event is EmptyEvent){
        yield SignUpUninitialized();
      }
    }catch(e){
      yield SignUpError(e.toString());
    }
  }
}