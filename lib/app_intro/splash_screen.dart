import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_bloc.dart';
import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_event.dart';
import 'package:Hackathon/utils/on_widget_did_build.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

/// <h1>splash_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 2:26 pm
/// 

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AppFlowBloc appFlowBloc;

  @override
  void initState() {
    super.initState();
    appFlowBloc = BlocProvider.of<AppFlowBloc>(context);
    onWidgetDidBuild(()async{
       Future.delayed(Duration(seconds: 2)).then((value){
         appFlowBloc.add(WelcomeEvent());
       });

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return Center(
      child: Text("splash"),
    );
  }
}
