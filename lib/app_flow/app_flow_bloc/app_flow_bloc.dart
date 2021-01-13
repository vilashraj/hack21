import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_flow_event.dart';
import 'app_flow_state.dart';

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

/// <h1>app_flow_bloc</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:03 pm
/// 

class AppFlowBloc extends Bloc<AppFlowEvent, AppFlowState> {
  AppFlowBloc(AppFlowState initialState) : super(initialState);

  @override
  Stream<AppFlowState> mapEventToState(AppFlowEvent event) async*{
    if(event is SplashEvent){
      yield SplashState();
    }
    else if(event is WelcomeEvent){
      yield WelcomeState();
    }
    else if(event is AppIntroEvent){
      yield LoginState();
    }
    else if(event is LoginEvent){
      yield LoginState();
    }
    else if(event is SignUpEvent){
      yield SignUpState();
    }
    else if(event is ProfileEvent){
      yield ProfileState();
    }
    else if(event is DashboardEvent){
      yield DashboardState();
    }
    else if(event is LogoutEvent){
      yield LoginState();
    }

  }

}