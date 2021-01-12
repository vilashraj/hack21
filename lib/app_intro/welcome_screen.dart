import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_bloc.dart';
import 'package:Hackathon/app_flow/app_flow_bloc/app_flow_event.dart';
import 'package:Hackathon/app_intro/welcome_background.dart';
import 'package:Hackathon/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

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

/// <h1>welcome_screen</h1>
/// 
/// <p>
/// 
/// @author Vilashraj Patel (vilashp@meditab.com) Meditab Software Inc.
/// @version 1.0
/// @since 1/12/21 1:18 pm
/// 

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  // ignore: close_sinks
  AppFlowBloc appFlowBloc;
  Size size;


  @override
  void initState() {
    appFlowBloc = BlocProvider.of<AppFlowBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return WelcomeBackground(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                appFlowBloc.add(LoginEvent());
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                appFlowBloc.add(SignUpEvent());

              },
            ),
          ],
        ),
      ),
    );
  }
}