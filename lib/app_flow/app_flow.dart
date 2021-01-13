import 'package:Hackathon/app_intro/splash_screen.dart';
import 'package:Hackathon/app_intro/welcome_screen.dart';
import 'package:Hackathon/authentication/login/login_screen.dart';
import 'package:Hackathon/authentication/sign_up/sign_up_screen.dart';
import 'package:Hackathon/dashboard/dashboard_screen.dart';
import 'package:Hackathon/profile/profile_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_flow_bloc/app_flow_bloc.dart';
import 'app_flow_bloc/app_flow_state.dart';

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

/// <h1>app_flow</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:07 pm
/// 

class AppFlow extends StatefulWidget {
  @override
  _AppFlowState createState() => _AppFlowState();
}

class _AppFlowState extends State<AppFlow> {

  AppFlowBloc appFlowBloc;

  @override
  void initState() {
    Firebase.initializeApp(

    );
  appFlowBloc = AppFlowBloc(SplashState());
  super.initState();
  }
  @override
  void dispose() {
    appFlowBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return BlocProvider(
      create: (context) => appFlowBloc,
      child: BlocBuilder(
        cubit: appFlowBloc,
        builder: (BuildContext context, AppFlowState state) {

          if(state is SplashState){
            return SplashScreen();
          }
          else if(state is LoginState){
            return LoginScreen();
          }
          else if(state is SignUpState){
            return SignUpScreen();
          }
          else if(state is WelcomeState){
            return WelcomeScreen();
          }
          else if(state is DashboardState){
            return DashboardScreen();
          }
          else if(state is ProfileState){
            return ProfileUi(newlyCreatedProfile: true,);
          }
        return Container();
      },

      ),
    );
  }
}
